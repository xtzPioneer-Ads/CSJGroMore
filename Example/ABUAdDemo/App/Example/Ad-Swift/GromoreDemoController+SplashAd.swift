//
//  GromoreDemoController+SplashAd.swift
//  ABUDemo
//
//  Created by bytedance on 2022/3/10.
//  Copyright © 2022 bytedance. All rights reserved.
//
// Splash广告加载Demo

import UIKit

@objc extension GromoreDemoController : ABUSplashAdDelegate, ABUZoomOutSplashAdDelegate {
    
    /// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
    public func loadSplashAd(withConfig config: GromoreAdLoadConfig!, andParam param: GromoreAdLoadParam!) {
        
        // 初始化广告加载对象
        self.splashAd = ABUSplashAd.init(adUnitID: config.slotID)
        // 配置广告信息项，以下仅展示部分功能，详细配置项请参考`ABUSplashAd.h`文件
        // 配置：跳转控制器
        self.splashAd?.rootViewController = UIApplication.shared.keyWindow?.rootViewController
        // 配置：回调代理对象
        self.splashAd?.delegate = self
        // [可选]配置：是否开启点睛功能，默认不开启
        self.splashAd?.needZoomOutIfCan = true
        // [可选]配置：是否展示卡片视图，默认不开启，仅支持穿山甲广告
        self.splashAd?.supportCardView = true
        // [可选]配置：自定义底部视图，可以设置LOGO等，仅部分ADN支持
        let botttomView = UILabel.init()
        botttomView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        botttomView.backgroundColor = UIColor.red
        botttomView.textAlignment = .center
        botttomView.text = "这是一个展示在广告底部的视图"
        self.splashAd?.customBottomView = botttomView
        // [可选]配置：兜底方案，在配置拉取失败时会按照该方案进行广告加载
        let userData = ABUSplashUserData()
        userData.adnName = "pangle"
        userData.rit = ""
        userData.appID = ""
        userData.appKey = nil
        self.splashAd?.setUserData(userData, error: nil)
        
        // 开始加载广告
        self.splashAd?.loadData()
    }
    
    /// Demo中定义的广告加载方法，在Demo中点击展示广告后触发该方法
    public func showSplashAd() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        self.splashAd?.show(in: window)
    }
    
    // MARK: - ABUSplashAdDelegate
    /// 加载成功回调
    public func splashAdDidLoad(_ splashAd: ABUSplashAd) {
        // 处理开屏点睛
        if splashAd.zoomOutView != nil && splashAd.zoomOutView?.addOccasionType == .whenLoad {
            _showZoomOutView()
        }
    }
    
    /// 加载失败回调
    public func splashAd(_ splashAd: ABUSplashAd, didFailWithError error: Error?) {
        
    }
    
    /// 展示回调
    public func splashAdWillVisible(_ splashAd: ABUSplashAd) {
        
    }
    
    /// 展示失败回调
    public func splashAdDidShowFailed(_ splashAd: ABUSplashAd, error: Error) {
        
    }
    
    /// 点击回调
    public func splashAdDidClick(_ splashAd: ABUSplashAd) {
        
    }
    
    /// 关闭回调
    public func splashAdDidClose(_ splashAd: ABUSplashAd) {
        // 命中开屏点睛
        if splashAd.zoomOutView != nil && splashAd.zoomOutView?.addOccasionType == .whenClose {
            // 处理收缩的开屏点睛View
            _showZoomOutView()
        } else {
            // 非开屏zoomout在此销毁
            splashAd.destoryAd()
        }
    }
    
    public func splashAdCountdown(toZero splashAd: ABUSplashAd) {
        
    }
    
    public func splashAdWillDismissFullScreenModal(_ splashAd: ABUSplashAd) {
        
    }
    
    // MARK: - ABUZoomOutSplashAdDelegate && Support
    public func splashZoomOutViewAdDidClick(_ splashZoomOutView: UIView) {
        
    }
    
    public func splashZoomOutViewAdDidClose(_ splashZoomOutView: UIView) {
        
    }
    
    public func splashZoomOutViewAdDidPresentFullScreenModal(_ splashZoomOutView: UIView) {
        
    }
    
    public func splashZoomOutViewAdDidDismissFullScreenModal(_ splashZoomOutView: UIView) {
        
    }
    
    private func _showZoomOutView() {
        guard let zoomOutView = splashAd?.zoomOutView else {
            return
        }
        // Required 设置delegate
        zoomOutView.delegate = self
        // Required设置zoomOutView的根vc，不设置默认和splashAd的一致;!!!若要更改该设置，必须在splashAdshow之后进行赋值
//        zoomOutView.rootViewController = self
        view.addSubview(zoomOutView)
        
        // Required size值时为SDK给定的建议值或比例(且最小不得小于suggestedSize)
        var size = CGSize(width: 200, height: 420)
        if zoomOutView.suggestedSize.width > 0 && zoomOutView.suggestedSize.height > 0 {
            size = zoomOutView.suggestedSize
        }
        // origin位置按需设置
        let rect = CGRect(x: 414 - size.width - 60, y: 818 - size.height - 60, width: size.width, height: size.height)
        
        // 若adn的开屏点睛没有自带动画，开发者可按实际情况自行实现动画
        if zoomOutView.hasAnimation == false {
            // 简单动画示例，开发者亦可自行实现更好的动画效果
            UIView.transition(with: zoomOutView, duration: 0.25, options: .curveEaseOut) {
                zoomOutView.frame = rect
            }
        } else {
            zoomOutView.frame = rect
        }
        
    }
    
    
    // MARK: - 以下为Demo实现逻辑，请勿模仿
    
    public func resetSplashAd () {
        self.splashAd?.delegate = nil
        self.splashAd = nil
    }
}
