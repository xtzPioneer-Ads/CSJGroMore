//
//  GromoreDemoController+InterstitialProAd.swift
//  ABUDemoSwift
//
//  Created by yinyin on 2022/6/9.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 插全屏广告加载Demo

import UIKit

@objc extension GromoreDemoController: ABUInterstitialProAdDelegate {

    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadInterstitialProAd(withConfig config: GromoreAdLoadConfig!, andParam param: GromoreAdLoadParam!) {
        // 初始化广告加载对象
        self.interstitialProAd = ABUInterstitialProAd.init(adUnitID: config.slotID, sizeForInterstitial: CGSize.init(width: 300, height: 300 * 3 / 2.0))
        // 配置：回调代理对象
        self.interstitialProAd?.delegate = self
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUInterstitialProAd.h`文件
        // [可选]配置：静音
        self.interstitialProAd?.mutedIfCan = true;
        // [可选]配置：设置奖励信息
        let rewardModel = ABURewardedVideoModel.init()
        rewardModel.userId = "xxxx"
        rewardModel.rewardName = "金币"
        rewardModel.rewardAmount = 1000
        rewardModel.extra = "{}"
        self.interstitialProAd?.rewardModel = rewardModel
        
        // 开始加载广告
        self.interstitialProAd?.loadData()
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showInterstitialProAd() {
        self.interstitialProAd?.show(fromRootViewController: self, extraInfos: nil)
    }
    
    // MARK: - ABUInterstitialAdDelegate
    /// 加载成功回调
    public func interstitialProAdDidLoad(_ interstitialProAd: ABUInterstitialProAd) {
        
    }
    
    /// 加载失败回调
    public func interstitialProAd(_ interstitialProAd: ABUInterstitialProAd, didFailWithError error: Error?) {
        
    }
    
    /// 展示成功回调
    public func interstitialProAdDidVisible(_ interstitialProAd: ABUInterstitialProAd) {
        
    }
    
    /// 展示失败回调
    public func interstitialProAdDidShowFailed(_ interstitialProAd: ABUInterstitialProAd, error: Error) {
        
    }
    
    /// 点击回调
    public func interstitialProAdDidClick(_ interstitialProAd: ABUInterstitialProAd) {
        
    }
    
    /// 关闭回调
    public func interstitialProAdDidClose(_ interstitialProAd: ABUInterstitialProAd) {
        
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿

    public func resetInterstitialProAd () {
        self.interstitialProAd?.delegate = nil
        self.interstitialProAd = nil
    }
}
