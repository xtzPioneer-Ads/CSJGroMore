#
# Be sure to run `pod lib lint CSJGroMore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CSJGroMore'
  s.version          = '4.3.0.0'
  s.summary          = '穿山甲GroMore广告SDK。'
  s.description      = <<-DESC
  穿山甲GroMore广告SDK。
  官方版本：4.3.0.0
  官方修订版本：2023-06-27 22:17:33
  官方修订说明：1.适配ADN版本，详见SDK前置说明模块；2.修复已知问题，性能优化；
                       DESC
  s.homepage         = 'https://github.com/xtzPioneer-Ads/CSJGroMore'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张雄' => 'xtz_pioneer@icloud.com' }
  s.source           = { :git => 'https://github.com/xtzPioneer-Ads/CSJGroMore.git', :tag => s.version.to_s }
  
  s.platform     = :ios, '11.0'
  
  s.requires_arc = true
  s.static_framework = true
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  valid_archs = ['arm64', 'armv7', 'x86_64', 'i386']

  s.source_files = 'CSJGroMore/Classes/**/*.{h,m}'
  s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.resource_bundles = {
     'CSJGroMore' => ['CSJGroMore/Assets/*.{png}']
  }
  
  # 1.GroMoreSDK核心库
  
  # Ads-Mediation-CN
  s.subspec 'Ads-Mediation-CN' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/Ads-Mediation-CN_4.3.0.0/Ads-Mediation-CN/ABUAdSDK.framework'
      ss.dependency "BURelyFoundation"
      ss.libraries = 'sqlite3', 'xml2', 'z'
      ss.frameworks = 'SystemConfiguration', 'CoreGraphics', 'Foundation', 'UIKit', 'AdSupport', 'StoreKit', 'QuartzCore', 'CoreTelephony', 'MobileCoreServices', 'Accelerate', 'AVFoundation', 'WebKit'
  end
  
  # 2.GroMore官方适配adapter
  
  # Admob/GoogleAd
  s.subspec 'ABUAdAdmobAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdAdmobAdapter_10.0.0.0/ABUAdAdmobAdapter/ABUAdAdmobAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # 百度
  s.subspec 'ABUAdBaiduAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdBaiduAdapter_5.14.0/ABUAdBaiduAdapter/ABUAdBaiduAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # 穿山甲
  s.subspec 'ABUAdCsjAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdCsjAdapter_5.3.0.4.0/ABUAdCsjAdapter/ABUAdCsjAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # 广点通/优量汇
  s.subspec 'ABUAdGdtAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdGdtAdapter_4.14.30.0/ABUAdGdtAdapter/ABUAdGdtAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # 游可赢
  s.subspec 'ABUAdKlevinAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdKlevinAdapter_2.11.0.211.0/ABUAdKlevinAdapter/ABUAdKlevinAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # 快手
  s.subspec 'ABUAdKsAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdKsAdapter_3.3.44.0/ABUAdKsAdapter/ABUAdKsAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # MintegralAdSDK
  s.subspec 'ABUAdMintegralAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdMintegralAdapter_7.3.6.0/ABUAdMintegralAdapter/ABUAdMintegralAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end
  
  # SigmobAd
  s.subspec 'ABUAdSigmobAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdSigmobAdapter_4.8.0.0/ABUAdSigmobAdapter/ABUAdSigmobAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # UnityAds
  s.subspec 'ABUAdUnityAdapter' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUAdUnityAdapter_4.3.0.0/ABUAdUnityAdapter/ABUAdUnityAdapter.framework'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end

  # 3.GroMoreSDK调试
  
  # ABUVisualDebug
  s.subspec 'ABUVisualDebug' do |ss|
      ss.vendored_frameworks = 'CSJGroMore/SDKs/4.3.0.0/ABUVisualDebug_4.3.0.0/ABUVisualDebug/ABUVisualDebug.framework'
      ss.resource = 'CSJGroMore/SDKs/4.3.0.0/ABUVisualDebug_4.3.0.0/ABUVisualDebug/ABUVisualDebug.bundle'
      ss.dependency 'CSJGroMore/Ads-Mediation-CN'
      ss.dependency "BURelyFoundation"
  end
  
end
