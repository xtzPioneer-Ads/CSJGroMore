# CSJGroMore
穿山甲GroMore广告SDK。

## 官方GroMore
[穿山甲GroMore官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=79&osType=ios&locale=zh-CN&backPath=/union/media/union/download/groMore)
<p>官方版本：4.2.0.3<br>
<p>官方修订版本：2023-05-26<br>
<p>官方修订说明：适配ADN版本，详见SDK前置说明模块<br>

## 使用CocoaPods安装
```ruby
source 'https://github.com/xtzPioneer-Ads/AdsSpecs.git'
```
```ruby
pod 'CSJGroMore', '~> 4.2.0.3'
```
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
```

## 依赖说明
默认依赖(百度,穿山甲,广点通/优量汇,快手)广告SDK

