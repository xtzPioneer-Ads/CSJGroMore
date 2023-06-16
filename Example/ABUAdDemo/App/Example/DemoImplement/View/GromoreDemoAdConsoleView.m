//
//  GromoreDemoAdConsoleView.m
//  ABUDemo
//
//  Created by bytedance on 2022/2/11.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "GromoreDemoAdConsoleView.h"
#import "GromoreDemoCustomDefine.h"
#import "fishhook.h"
#import "GroMore.h"

@interface GromoreDemoAdConsoleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *contentView;

@property (nonatomic, strong) UISwitch *autoScrollButton;

@property (nonatomic, copy) NSString *filterWords;
@end

@implementation GromoreDemoAdConsoleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        self.filterWords = [NSString stringWithFormat:@"[%@]", [ABUAdSDKManager SDKVersion]];
    }
    return self;
}

- (instancetype)init {
    CGFloat x = CGRectGetWidth([UIScreen mainScreen].bounds) / 3;
    CGFloat y = CGRectGetMaxY([UIScreen mainScreen].bounds) - 300;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / 3 * 2 - 5;
    CGFloat height = 200;
    CGRect frame = CGRectMake(x, y, width, height);
    if (self = [self initWithFrame:frame]) {}
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = GROMORE_666666_Color.CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 4.f;
    self.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @" 控制台输出内容(可拖动)";
    label.font = GROMORE_PingFangSC_Font(8);
    label.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragAction:)];
    [label addGestureRecognizer:pan];
    self.titleLabel = label;
    [self addSubview:label];
    
    _contentView = [[UITextView alloc] init];
    _contentView.backgroundColor = [UIColor blackColor];
    _contentView.textColor = GROMORE_666666_Color;
    _contentView.editable = NO;
    _contentView.alpha = 1.0f;
    [self addSubview:_contentView];
    
    // 自动滚动
    _autoScrollButton = [[UISwitch alloc] init];
    _autoScrollButton.tintColor = GROMORE_338AFF_Color;
    _autoScrollButton.transform = CGAffineTransformMakeScale(0.5, 0.5);
    _autoScrollButton.on = YES;
    _autoScrollButton.alpha = 1.0f;
    [self addSubview:_autoScrollButton];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    super.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.titleLabel.frame = CGRectMake(0, 0, width, 20);
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), width, height - CGRectGetHeight(self.titleLabel.bounds));
    self.autoScrollButton.frame = CGRectMake(width - 30, 2.5f, 30, 30);
}

- (void)dragAction:(UIPanGestureRecognizer *)pan {
    CGPoint trans = [pan translationInView:self];
    self.frame = CGRectOffset(self.frame, trans.x, trans.y);
    [pan setTranslation:CGPointZero inView:self];
}

- (void)setHidden:(BOOL)hidden {
    static dispatch_once_t onceToken;
    static NSLock *_lock = nil;
    dispatch_once(&onceToken, ^{
        _lock = [[NSLock alloc] init];
    });
    [_lock lock];
    if (hidden) {
        // 动画由大变小
        self.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.1f;
            self.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, 0, 0);
        } completion:^(BOOL finished) {
            self.alpha = 0.f;
            self.transform = CGAffineTransformIdentity;
            [self stopMonitor];
        }];
    } else {
        // 动画由小变大
        self.transform = CGAffineTransformMake(0.0, 0, 0, 0.0, 0, 0);
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.7;
            self.transform = CGAffineTransformMake(1.f, 0, 0, 1.f, 0, 0);
        } completion:^(BOOL finished) {
            //  恢复原位
            self.transform = CGAffineTransformIdentity;
            [self startMonitor];
        }];
    }
    [_lock unlock];
}

- (void)startMonitor {
    [[GromoreDemoAdConsoleView _monitors] addObject:self];
}

- (void)stopMonitor {
    [[GromoreDemoAdConsoleView _monitors] removeObject:self];
}

- (void)log:(NSString *)string {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![string containsString:self.filterWords]) return;
        self.contentView.text = [self.contentView.text stringByAppendingFormat:@"\n%@",string];
        if (!self.autoScrollButton.isOn) return;
        NSRange bottom = NSMakeRange(self.contentView.text.length -1, 1);
        [self.contentView scrollRangeToVisible:bottom];
    });
}

+ (NSMutableSet *)_monitors {
    static NSMutableSet *_set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _set = [NSMutableSet set];
    });
    return _set;
}

@end

static void (*Gromore_ORI_NSLog)(NSString *format, ...);

static void Gromore_NSLog(NSString *format, ...) {
    va_list list;
    va_start(list, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:list];
    if (string) {
        [[[GromoreDemoAdConsoleView _monitors] copy] enumerateObjectsUsingBlock:^(GromoreDemoAdConsoleView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj log:string];
        }];
    }
    va_end(list);
    Gromore_ORI_NSLog(@"%@",string);
}

@implementation GromoreDemoAdConsoleView (HOOK)

// + (void)load {
//     if (Gromore_ORI_NSLog == NULL) {
//         struct rebinding mybind;
//         mybind.name = "NSLog";
//         mybind.replacement = Gromore_NSLog;
//         mybind.replaced = (void *)&Gromore_ORI_NSLog;

//         struct rebinding rebns[] = {mybind};
//         rebind_symbols(rebns, 1);
//     }
// }

@end
