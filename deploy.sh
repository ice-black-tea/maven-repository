#!/bin/bash

if [ $# != 1 ];then
  echo 'deploy argument [snapshot(s for short) | release(r for short) ] needed!'
  exit 0
fi

## deploy参数，snapshot 表示快照包，简写为s， release表示正式包，简写为r
arg=$1

CURRENT_PATH=`pwd`
REPOSITORY_PATH="$(dirname $0)"

deploy(){
  br=$1
  ## 快照包发布
  cd $REPOSITORY_PATH
  ## 切换对应分支
  git checkout $br
  cd $CURRENT_PATH
  # 开始deploy
  mvn clean deploy -Dmaven.test.skip  -DaltDeploymentRepository=self-mvn-repo::default::file:$REPOSITORY_PATH/repository

  # deploy 完成,提交
  cd $REPOSITORY_PATH
  git commit -am 'deploy'
  git push origin $br

  # 合并master分支
  git checkout master
  git merge $br
  git commit -am 'merge'
  git push origin master
  cd $CURRENT_PATH
}

if [ $arg = 'snapshot' ] || [ $arg = 's' ];then
  ## 快照包发布
  deploy snapshot
elif [ $arg = 'release' ] || [ $arg = 'r' ];then
  ## 正式包发布
  deploy release
else
  echo 'argument should be snapshot(s for short) or release(r for short). like: `sh deploy.sh snapshot` or `sh deploy.sh s`'
fi
