//
//  GromoreDemoController+RewardedVideoAd.swift
//  ABUDemoSwift
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// 激励视频广告加载Demo

import UIKit

@objc extension GromoreDemoController: ABURewardedVideoAdDelegate {
    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadRewardedVideoAd(withConfig config: GromoreAdLoadConfig!, andParam: GromoreAdLoadParam!) {
        // 初始化广告加载对象
        self.rewardedVideoAd = ABURewardedVideoAd.init(adUnitID: config.slotID)
        // 配置：回调代理对象
        self.rewardedVideoAd?.delegate = self
        // [可选]配置：再看一个回调代理对象
        self.rewardedVideoAd?.rewardPlayAgainDelegate = self
        // [可选]配置：设置是否静音
        self.rewardedVideoAd?.mutedIfCan = true;
        // [可选]配置：设置奖励信息
        let rewardModel = ABURewardedVideoModel.init()
        rewardModel.userId = "xxxx"
        rewardModel.rewardName = "金币"
        rewardModel.rewardAmount = 1000
        rewardModel.extra = "{}"
        self.rewardedVideoAd?.rewardedVideoModel = rewardModel
        
        // 开始加载广告
        self.rewardedVideoAd?.loadData()
        
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法，需在广告加载完成之后调用/
    public func showRewardedVideoAd() {
        self.rewardedVideoAd?.show(fromRootViewController: self)
    }
    
    // MARK: ABURewardedVideoAdDelegate
    /// 加载成功回调
    public func rewardedVideoAdDidLoad(_ rewardedVideoAd: ABURewardedVideoAd) {
        
    }
    
    /// 缓存成功回调
    public func rewardedVideoAdDidDownLoadVideo(_ rewardedVideoAd: ABURewardedVideoAd) {
        
    }
    
    /// 加载失败回调
    public func rewardedVideoAd(_ rewardedVideoAd: ABURewardedVideoAd, didFailWithError error: Error?) {
        
    }
    
    /// 展示成功回调
    public func rewardedVideoAdDidVisible(_ rewardedVideoAd: ABURewardedVideoAd) {
        
    }
    
    /// 展示失败回调
    public func rewardedVideoAdDidShowFailed(_ rewardedVideoAd: ABURewardedVideoAd, error: Error) {
        
    }
    
    /// 点击回调
    public func rewardedVideoAdDidClick(_ rewardedVideoAd: ABURewardedVideoAd) {
        
    }
    
    /// 跳过回调
    public func rewardedVideoAdDidSkip(_ rewardedVideoAd: ABURewardedVideoAd) {
        
    }
    
    /// 关闭回调
    public func rewardedVideoAdDidClose(_ rewardedVideoAd: ABURewardedVideoAd) {
        
    }
    
    /// 播放完成回调
    public func rewardedVideoAd(_ rewardedVideoAd: ABURewardedVideoAd, didPlayFinishWithError error: Error?) {
        
    }
    
    /// 服务端验证回调
    public func rewardedVideoAdServerRewardDidSucceed(_ rewardedVideoAd: ABURewardedVideoAd, rewardInfo: ABUAdapterRewardAdInfo?, verify: Bool) {
        
    }
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿
    
    public func resetRewardedVideoAd() {
        self.rewardedVideoAd?.delegate = nil
        self.rewardedVideoAd = nil
    }
}
