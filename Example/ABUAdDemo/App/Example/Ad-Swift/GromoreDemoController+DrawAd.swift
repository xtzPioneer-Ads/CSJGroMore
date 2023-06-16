//
//  GromoreDemoController+DrawAd.swift
//  ABUDemoSwift
//
//  Created by yinyin on 2022/6/9.
//  Copyright © 2022 bytedance. All rights reserved.
//
// Draw广告加载Demo

import UIKit

@objc extension GromoreDemoController: ABUDrawAdsManagerDelegate,ABUDrawAdViewDelegate,ABUDrawAdVideoDelegate {
    
    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadDrawAd(withConfig config: GromoreAdLoadConfig!, andParam param: GromoreAdLoadParam!) {
        // 初始化广告加载对象
        self.drawAd = ABUDrawAdsManager.init(adUnitID: config.slotID, adSize: config.adSize)
        // 配置：跳转控制器
        self.drawAd?.rootViewController = self;
        // 配置：回调代理对象
        self.drawAd?.delegate = self;
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUDrawAdsManager.h`文件
        
        // 开始加载广告
        self.drawAd?.loadAdData(withCount: 1)
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showDrawAd () {
        self.showAdView { size in
            self.drawAdView?.frame = CGRect.init(origin: CGPoint.zero, size: size)
            guard let drawView = self.drawAdView else {
                return nil
            }
            if drawView.isExpressAd {
                // 模板广告：使用ADN的渲染方法进行渲染
                drawView.render()
            } else {
                // 自渲染广告：开发者需自行渲染
                drawView.customRender()
            }
            return drawView
        }
    }
    
    // MARK: - ABUNativeAdDelegate
    /// 加载成功回调
    public func drawAdsManagerSuccess(toLoad adsManager: ABUDrawAdsManager, drawVideoAds drawAds: [ABUDrawAdView]?) {
        
        self.drawAdView = drawAds?.first
        
        // 重点:务必设定后续回调代理
        self.drawAdView?.delegate = self
        self.drawAdView?.videoDelegate = self
    }
    
    /// 加载失败回调
    public func drawAdsManager(_ adsManager: ABUDrawAdsManager, didFailWithError error: Error?) {
        
    }
    
    /// 展示成功回调
    public func drawAdDidBecomeVisible(_ drawAdView: ABUDrawAdView) {
        
    }
    
    /// 点击回调
    public func drawAdVideoDidClick(_ drawAdView: ABUDrawAdView?) {
        
    }
    
    /// 关闭回调
    public func drawAdDidClosed(_ drawAdView: ABUDrawAdView?, closeReason filterWords: [[AnyHashable : Any]]?) {
        
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿
    public func resetDrawAd () {
        self.drawAd?.delegate = nil
        self.drawAd = nil
        self.drawAdView = nil
    }
}
