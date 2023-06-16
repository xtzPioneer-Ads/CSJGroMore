//
//  GromoreDemoController+NativeAd.swift
//  ABUDemoSwift
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 信息流广告加载Demo

import UIKit
 
//private var nativeAdViewKey : Void?

@objc extension GromoreDemoController: ABUNativeAdsManagerDelegate,ABUNativeAdViewDelegate,ABUNativeAdVideoDelegate {
    
    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法/
    public func loadNativeAd(withConfig config: GromoreAdLoadConfig!, andParam param: GromoreAdLoadParam!) {
        // 初始化广告加载对象
        self.nativeAd = ABUNativeAdsManager.init(adUnitID: config.slotID, adSize: config.adSize)
        // 配置：跳转控制器
        self.nativeAd?.rootViewController = self;
        // 配置：回调代理对象
        self.nativeAd?.delegate = self
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUNativeAdsManager.h`文件
        // [可选]配置：摇一摇视图配置
        self.nativeAd?.addParam(NSValue.init(cgRect: CGRect(x: 0, y: 0, width: 200, height: 200)), withKey: ABUAdLoadingParamNAExpectShakeViewFrame)
        // [可选]配置：静音
        self.nativeAd?.startMutedIfCan = true
        
        // 开始加载广告
        self.nativeAd?.loadData()
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showNativeAd () {
        self.showAdView { size in
            self.nativeAdView?.frame = CGRect.init(origin: CGPoint.zero, size: size)
            
            if (self.nativeAdView!.isExpressAd) {
                // 模板广告：使用ADN的渲染方法进行渲染
                self.nativeAdView?.render()
            } else {
                // 自渲染广告：开发者需自行渲染
                self.nativeAdView?.customRender()
            }
            return self.nativeAdView
        }
    }
    
    // MARK: - ABUNativeAdDelegate
    /// 加载成功回调
    public func nativeAdsManagerSuccess(toLoad adsManager: ABUNativeAdsManager, nativeAds nativeAdViewArray: [ABUNativeAdView]?) {
        self.nativeAdView = nativeAdViewArray?.first
        
        // 重点:务必设定后续回调代理
        self.nativeAdView?.delegate = self
        self.nativeAdView?.videoDelegate = self
    }
    
    /// 加载失败回调
    public func nativeAdsManager(_ adsManager: ABUNativeAdsManager, didFailWithError error: Error?) {
        
    }
    
    /// 展示成功回调
    public func nativeAdDidBecomeVisible(_ nativeAdView: ABUNativeAdView) {
        
    }
    
    /// 点击回调
    public func nativeAdVideoDidClick(_ nativeAdView: ABUNativeAdView?) {
        
    }
    
    /// 关闭回调
    public func nativeAdExpressViewDidClosed(_ nativeAdView: ABUNativeAdView?, closeReason filterWords: [[AnyHashable : Any]]?) {
        
    }
    
    public func nativeAdViewDidDismissFullScreenModal(_ nativeAdView: ABUNativeAdView?) {
        
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿
    
    public func resetNativeAd () {
        self.nativeAd?.delegate = nil
        self.nativeAd = nil
        self.nativeAdView = nil
    }
}
