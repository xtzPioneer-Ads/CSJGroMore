//
//  ViewController.h
//  Ads-Mediation-CN-demo
//
//  Created by heyinyin on 2021/12/30.
//

#import <UIKit/UIKit.h>
#import "GroMore.h"
#import "GromoreAdLoadConfig.h"
#import "GromoreDemoLoadAdView.h"

@interface GromoreDemoController : UIViewController

@property (nonatomic, assign, readonly) BOOL showAdAfterLoad;

- (void)showAdView:(UIView *(^)(CGSize size))viewBlock;

- (void)adStatusChanged:(GromoreDemoAdStatus)status;

- (void)loadedExtra;

- (void)loadFailedExtra;

- (void)closeExtra;
@end

