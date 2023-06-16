//
//  GromoreDemoController+BannerAd.swift
//  ABUDemoSwift
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// Banner广告加载Demo

import UIKit

private var bannerViewKey : Void?

@objc extension GromoreDemoController: ABUBannerAdDelegate {
    
    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadBannerAd(withConfig config: GromoreAdLoadConfig!, andParam param: GromoreAdLoadParam!) {
        
        // 初始化广告加载对象
        self.bannerAd = ABUBannerAd.init(adUnitID: config.slotID, rootViewController: self, adSize: config.adSize)
        // 配置：回调代理对象
        self.bannerAd?.delegate = self
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUBannerAd.h`文件
        // [可选]混用信息流时可选配置：静音
        self.bannerAd?.startMutedIfCan = true
        // 轮播相关配置需要在平台配置
        
        // 开始加载广告
        self.bannerAd?.loadData()
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showBannerAd () {
        self.showAdView { size in
            return self.bannerView
        }
    }
    
    // MARK: - ABUBannerAdDelegate
    /// 加载成功回调
    public func bannerAdDidLoad(_ bannerAd: ABUBannerAd, bannerView: UIView) {
        self.bannerView = bannerView
    }
    
    /// 加载失败回调
    public func bannerAd(_ bannerAd: ABUBannerAd, didLoadFailWithError error: Error?) {
        print(error as Any)
    }
    
    /// 展示成功回调
    public func bannerAdDidBecomeVisible(_ bannerAd: ABUBannerAd, bannerView: UIView) {
        
    }
    
    /// 点击回调
    public func bannerAdDidClick(_ ABUBannerAd: ABUBannerAd, bannerView: UIView) {
        
    }
    
    /// 关闭回调
    public func bannerAdDidClosed(_ ABUBannerAd: ABUBannerAd, bannerView: UIView, dislikeWithReason filterwords: [[AnyHashable : Any]]?) {
        
    }
    
    /// 混用信息流自渲染广告时会回调该方法，开发者需要在该回调中布局自渲染视图
    public func bannerAdNeedLayoutUI(_ bannerAd: ABUBannerAd, canvasView: ABUCanvasView) {
        // 在此按实际需要布局UI，可参考Demo中`-[ABUNativeAdView customRender]`
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿
    var bannerView : UIView? {
        get {
            return objc_getAssociatedObject(self, &bannerViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &bannerViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func resetBannerAd () {
        self.bannerAd?.delegate = nil
        self.bannerAd = nil
        self.bannerView = nil
    }
}
