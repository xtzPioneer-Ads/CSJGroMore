# CSJGroMore
穿山甲GroMore广告SDK。

## 官方GroMore
[穿山甲GroMore官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=79&osType=ios&locale=zh-CN&backPath=/union/media/union/download/groMore)
<p>官方版本：4.2.0.3<br>
<p>官方修订版本：2023-05-26<br>
<p>官方修订说明：适配ADN版本，详见SDK前置说明模块<br>

## 使用CocoaPods安装
```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/xtzPioneer-Ads/AdsSpecs.git'
```
```ruby
pod 'CSJGroMore', '~> 4.2.0.3'
```
```ruby
# 穿山甲
pod 'Ads-CN', '~> 5.3.0.4'
# 广点通/优量汇
pod 'GDTMobSDK', '~> 4.14.30'
# 快手
pod 'KSAdSDK', '~> 3.3.46'
# UnityAds
pod 'UnityAds', '~> 4.7.1'
# Admob/GoogleAd
pod 'Google-Mobile-Ads-SDK', '~> 10.6.0'
# 百度SDK
pod 'BaiduMobAdSDK', '~> 5.301'
# SigmobAd
pod 'SigmobAd-iOS', '~> 4.9.2'
# 游可赢
pod 'KlevinAdSDK', '~> 2.11.0.215'
# MintegralAdSDK
pod 'MintegralAdSDK', '~> 7.3.8'
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

## 使用实例
见Example

## 许可证
CSJGroMore 是根据麻省理工学院许可证发布的。[见许可证](https://github.com/xtzPioneer-Ads/CSJGroMore/blob/main/LICENSE)有关详细信息。
