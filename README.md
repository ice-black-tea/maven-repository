# maven仓库地址

```groovy
repositories {
    maven { url "https://github.com/ice-black-tea/maven-repository/raw/release/repository/" }
}
```

```groovy
dependencies {
    compileOnly 'ice.black.tea:android-17:1.0.0' // android 4.2 (jelly bean)
    compileOnly 'ice.black.tea:android-28:1.0.0' // android 9.0 (pie)
}
```
