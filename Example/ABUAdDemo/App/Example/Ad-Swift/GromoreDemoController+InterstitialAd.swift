//
//  GromoreDemoController+InterstitialAd.swift
//  ABUDemoSwift
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 插屏广告加载Demo

import UIKit

@objc extension GromoreDemoController: ABUInterstitialAdDelegate {

    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadInterstitialAd(withConfig config: GromoreAdLoadConfig!, andParam param: GromoreAdLoadParam!) {
        // 初始化广告加载对象
        self.interstitialAd = ABUInterstitialAd.init(adUnitID: config.slotID, size: CGSize.init(width: 300, height: 300 * 3 / 2.0))
        // 配置：回调代理对象
        self.interstitialAd?.delegate = self
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUInterstitialAd.h`文件
        // [可选]配置：静音
        self.interstitialAd?.mutedIfCan = true;
        
        // 开始加载广告
        self.interstitialAd?.loadData()
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showInterstitialAd() {
        self.interstitialAd?.show(fromRootViewController: self)
    }
    
    // MARK: - ABUInterstitialAdDelegate
    /// 加载成功回调
    public func interstitialAdDidLoad(_ interstitialAd: ABUInterstitialAd) {
        
    }
    
    /// 加载失败回调
    public func interstitialAd(_ interstitialAd: ABUInterstitialAd, didFailWithError error: Error?) {
        
    }
    
    /// 展示成功回调
    public func interstitialAdDidVisible(_ interstitialAd: ABUInterstitialAd) {
        
    }
    
    /// 展示失败回调
    public func interstitialAdDidShowFailed(_ interstitialAd: ABUInterstitialAd, error: Error) {
        
    }
    
    /// 点击回调
    public func interstitialAdDidClick(_ interstitialAd: ABUInterstitialAd) {
        
    }
    
    /// 关闭回调
    public func interstitialAdDidClose(_ interstitialAd: ABUInterstitialAd) {
        
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿

    public func resetInterstitialAd () {
        self.interstitialAd?.delegate = nil
        self.interstitialAd = nil
    }
}
