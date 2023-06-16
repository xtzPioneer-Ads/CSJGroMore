//
//  GromoreDemoController+FullscreenAd.swift
//  ABUDemoSwift
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 全屏视频广告加载Demo

import UIKit

@objc extension GromoreDemoController: ABUFullscreenVideoAdDelegate {
        
    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadFullscreenVideoAd(withConfig config: GromoreAdLoadConfig!, andParam: GromoreAdLoadParam!) {
        // 初始化广告加载对象
        self.fullscreenVideoAd = ABUFullscreenVideoAd.init(adUnitID: config.slotID)
        // 配置：回调代理对象
        self.fullscreenVideoAd?.delegate = self
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUFullscreenVideoAd.h`文件
        // [可选]配置：静音
        self.fullscreenVideoAd?.mutedIfCan = true;
        // [可选]配置：设置奖励信息
        let rewardModel = ABURewardedVideoModel.init()
        rewardModel.userId = "xxxx"
        rewardModel.rewardName = "金币"
        rewardModel.rewardAmount = 1000
        rewardModel.extra = "{}"
        self.fullscreenVideoAd?.rewardModel = rewardModel
        
        // 开始加载广告
        self.fullscreenVideoAd?.loadData()
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showFullscreenVideoAd () {
        self.fullscreenVideoAd?.show(fromRootViewController: self)
    }
    
    // MARK: - ABUFullscreenAdDelegate
    /// 加载成功回调
    public func fullscreenVideoAdDidLoad(_ fullscreenVideoAd: ABUFullscreenVideoAd) {
        
    }
    
    /// 加载失败回调
    public func fullscreenVideoAd(_ fullscreenVideoAd: ABUFullscreenVideoAd, didFailWithError error: Error?) {
        
    }
    
    /// 展示成功回调
    public func fullscreenVideoAdDidVisible(_ fullscreenVideoAd: ABUFullscreenVideoAd) {
        
    }
    
    /// 点击回调
    public func fullscreenVideoAdDidClick(_ fullscreenVideoAd: ABUFullscreenVideoAd) {
        
    }
    
    /// 关闭回调
    public func fullscreenVideoAdDidClose(_ fullscreenVideoAd: ABUFullscreenVideoAd) {
        
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿
    
    public func resetFullscreenVideoAd () {
        self.fullscreenVideoAd?.delegate = nil
        self.fullscreenVideoAd = nil
    }
}
