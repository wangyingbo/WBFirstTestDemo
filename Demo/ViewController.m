//
//  ViewController.m
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import "ViewController.h"
#import "School.h"
#import "DemoVC.h"
#import "UIImage+Scale.h"
#import <mach/task.h>
#import <mach/mach_init.h>
#import "YBTestMaskView.h"


#define FULL_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FULL_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()
{
    struct {
        __weak DemoVC *demoViewController;
    } _options;

    struct {
        unsigned int hasPrefetchManager: 1;
        unsigned int tableViewScrolling: 1;
        unsigned int tableViewReloading: 1;
    } _flags;
}

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, weak) UIView *dotView;
@property (nonatomic, strong) YBInfo *ybinfo;
@property (nonatomic, strong) YBInfo *secInfo;
@property (nonatomic, assign) BOOL exec;
@property (nonatomic, assign) NSInteger modalPresentStyle;

@property (nonatomic, assign) BOOL conditionOne;
@property (nonatomic, assign) BOOL conditionSecond;
@property (nonatomic, copy) NSString *conditionString;
@property (nonatomic, strong) UILabel *testLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self testDot];
    
    //[self testPerform];
    
    //[self testGradientLayer];
    
    //[self testSlider];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //NSLog(@"present一个vc，vc消失时，走didAppear");
    NSLog(@"%@的 did appear",NSStringFromClass(self.class));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    NSLog(@"present一个vc时，disappear");
    NSLog(@"%@的 will disappear",NSStringFromClass(self.class));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@的 did disappear",NSStringFromClass(self.class));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DemoVC *vc = [[DemoVC alloc] init];
    NSLog(@"1____%ld",vc.modalPresentationStyle);
    vc.modalPresentationStyle = self.modalPresentationStyle;
    NSLog(@"2____%ld",vc.modalPresentationStyle);
    self.modalPresentationStyle += 1;
    NSLog(@"3____%ld",vc.modalPresentationStyle);

//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    //[self addSliderDot];
    
//    NSString *result = [self findNumber:@[@1,@3,@58,@68,@456] k:@3];
//    NSLog(@"%@",result);
    
//    [self.ybinfo class];
//    self.exec = !self.exec;
//    self.secInfo.retainInfo = self.ybinfo;
//    [self.secInfo config:self.exec];
    
//    if ([self.conditionString isKindOfClass:NSString.class] &&
//        self.conditionString.length > 0) {
//        NSLog(@"all condition!!!");
//    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

#pragma mark - ui

- (void)setUI {
    
    [self setButtons];
    
    [self setMaskView];
}

- (void)setMaskView {
    CGFloat mask_w = 350.f;
    CGFloat mask_h = 250.f;
    YBTestMaskView *maskView = [[YBTestMaskView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - mask_w/2, 200.f, mask_w, mask_h)];
    [self.view addSubview:maskView];
}

- (void)setButtons {
    CGFloat button_w = 80.f;
    CGFloat button_h = 44.f;
    CGFloat leftMargin = 50.f;
    CGFloat rightMargin = leftMargin;
    CGFloat topMargin = 100.f;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, topMargin, button_w, button_h)];
    [leftButton setTitle:@"left" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - button_w - rightMargin, topMargin, button_w, button_h)];
    [rightButton setTitle:@"right" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    testLabel.numberOfLines = 1;
    testLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:.1f];
    [self.view addSubview:testLabel];
    self.testLabel = testLabel;
    //[self resetTestLabel];
    NSAttributedString *attriString = [self genAttriStringWithContent:nil];
    self.testLabel.attributedText = attriString;
}

#pragma mark - testLabel
UIFont *labelFont(void) {
    return [UIFont systemFontOfSize:14.f];
}

NSString *labelString (void) {
    return @"信息流合集分享样式包括：1、视频顶部头像+昵称+渐变蒙层；2、视频底部合集icon+合集标题+附属信息";
}

NSString *labelAttributedString (void) {
    return @"哈哈哈哈哈我试试效果怎么样撒非农是发送到发送到发送到发送到发送到发送到发";
}

- (void)layoutTestLabel {
    CGFloat label_max_w = FULL_SCREEN_WIDTH - 12 - 12;
    CGSize labelSize = [self.testLabel sizeThatFits:CGSizeMake(label_max_w, CGFLOAT_MAX)];
    self.testLabel.frame = CGRectMake(12.f, 64, MIN(labelSize.width, label_max_w), labelSize.height);
    self.testLabel.center = CGPointMake(self.view.center.x, self.testLabel.center.y);
}

- (void)resetTestLabel {
    self.testLabel.font = labelFont();
    self.testLabel.text = labelString();
    self.testLabel.textAlignment = NSTextAlignmentCenter;
    self.testLabel.textColor = [UIColor greenColor];
    [self layoutTestLabel];
    
}

/**
 iOS中关于AttributedString的那些事儿
 https://www.jianshu.com/p/d913658c2f1f
 */
- (void)changeLabelAttributedString {
    NSString *labelString = labelAttributedString();
    NSAttributedString *attString = [self genAttriStringWithContent:labelString];
    self.testLabel.attributedText = attString;
    [self layoutTestLabel];
}

- (NSAttributedString *)genAttriStringWithContent:(NSString *)content {
    NSString *originString = content?:@" ";
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowBlurRadius = 1.0;
    UIColor *titleColor = nil;
    titleColor = [UIColor redColor];
    shadow.shadowOffset = CGSizeMake(0, 10);
    shadow.shadowColor = [UIColor purpleColor];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:originString attributes:@{
        NSShadowAttributeName:shadow,
        NSForegroundColorAttributeName:titleColor,
        NSFontAttributeName:[UIFont systemFontOfSize:18.f]
    }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSRange range = NSMakeRange(0, originString.length);
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attString.copy;
}

#pragma mark - actions

- (void)leftButtonClick:(id)sender {
    [self resetTestLabel];
    return;
    
    DemoVC *vc = [[DemoVC alloc] init];
    NSLog(@"1____%ld",vc.modalPresentationStyle);
    vc.modalPresentationStyle = self.modalPresentationStyle;
    NSLog(@"2____%ld",vc.modalPresentationStyle);
    self.modalPresentationStyle += 1;
    NSLog(@"3____%ld",vc.modalPresentationStyle);

    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
    _options.demoViewController = vc;
    NSLog(@"yb____%@",_options.demoViewController);
}

- (void)rightButtonClick:(id)sender {
    NSLog(@"yb____%@",_options.demoViewController);
    
    [self changeLabelAttributedString];
}

#pragma mark - actions

- (BOOL)conditionOne {
    NSLog(@"条件一");
    return NO;
}

- (BOOL)conditionSecond {
    NSLog(@"条件二");
    return YES;
}

- (NSString *)conditionString {
    NSLog(@"条件string");
    return (NSString *)[NSNumber numberWithInteger:1];
    return @"";
}

static const int kStep = 50000;
static const int kIterationCount = 10 * kStep;
//查看app运行内存
- (void)obserMemoryUsage {
    NSNumber *num = nil;
    NSString *str = nil;
    for (int i = 0; i < kIterationCount; i++) {
        @autoreleasepool {
        
           num = [NSNumber numberWithInt:i];
          str = [NSString stringWithFormat:@"打哈萨克的哈克实打实的哈克时间的话大声疾呼多阿萨德爱仕达按时 "];
            
            //Use num and str...whatever...
            [NSString stringWithFormat:@"%@%@", num, str];
            
            if (i % kStep == 0) {
                double ff  =     getMemoryUsage();
                NSLog(@"%f",ff);
            }
        }
    }
}
double getMemoryUsage(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    double memoryUsageInMB = kerr == KERN_SUCCESS ? (info.resident_size / 1024.0 / 1024.0) : 0.0;
    return memoryUsageInMB;
}



- (void)testIMP {
    
}

- (YBInfo *)ybinfo {
    if (!_ybinfo) {
        _ybinfo = [[YBInfo alloc] init];
        _ybinfo.name = @"1";
    }
    return _ybinfo;
}

- (YBInfo *)secInfo {
    if (!_secInfo) {
        _secInfo = [[YBInfo alloc] init];
        _secInfo.name = @"2";
    }
    return _secInfo;
}

- (void)addSliderDot {
    if (self.dotView) {
        [self.dotView removeFromSuperview];
        return;
    }
    UIView *thumbView = [self.slider.subviews[0].subviews lastObject];
    UIView *containerView = thumbView.superview;
    UIView *dotView = [[UIView alloc]initWithFrame:CGRectMake(containerView.frame.size.width/2, containerView.frame.size.height/2 - 10, 20, 20)];
    dotView.backgroundColor = [UIColor redColor];
    dotView.layer.cornerRadius = 10.f;
    self.dotView = dotView;
    //[thumbView.superview insertSubview:dot belowSubview:thumbView];
    [self.slider.subviews[0] addSubview:dotView];
}

- (void)testSlider {
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 150, FULL_SCREEN_WIDTH - 40, 30)];
    slider.contentMode = UIViewContentModeScaleToFill;
    UIImage *originImage = [UIImage imageNamed:@"gao.jpg"];
    [slider setThumbImage:[originImage drawImageBySize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [self.view addSubview:slider];
    self.slider = slider;
    
    
    UIView *containerView = self.slider;
    UIView *dotView = [[UIView alloc]initWithFrame:CGRectZero];
    dotView.backgroundColor = [UIColor redColor];
    dotView.layer.cornerRadius = 10.f;
    self.dotView = dotView;
    [self.slider addSubview:dotView];
    [self.slider layoutIfNeeded];
    NSLog(@"%lu",(unsigned long)[slider.subviews firstObject].subviews.count);
}


- (void)testGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100,100,100,100);
    // 渐变色颜色数组,可多个
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor, nil];
    // 渐变的开始点
    gradientLayer.startPoint = CGPointMake(.5, 0); //(0, 0)
    // 渐变的结束点
    gradientLayer.endPoint = CGPointMake(.5, 1); //(1, 1)
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)testAttributedText {
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    NSMutableAttributedString *mutAttri = [[NSMutableAttributedString alloc] initWithString:@"测试一下哈哈哈哈哈"];
    
    
}


- (void)testPerform {
    if ([self respondsToSelector:@selector(updateWithBool:)]) {
        [self performSelector:@selector(updateWithBool:) withObject:@(YES)];
    }
}
- (void)updateWithBool:(BOOL)isPass {
    NSLog(@"当前传过来的值：%@",isPass?@"yes":@"no");
}

- (void)testDot {
    NSString *testString = @"1";
    NSLog(@"testString hash before :%ld",[testString hash]);
    testString = @"2";
    NSLog(@"testString hash after :%ld",[testString hash]);
    NSUInteger result4 = (NSUInteger)(uintptr_t)testString >> 4;
    NSLog(@"----4%ld",result4);
    NSUInteger result3 = (NSUInteger)(uintptr_t)testString >> 3;
    NSLog(@"----3%ld",result3);
    NSUInteger result2 = (NSUInteger)(uintptr_t)testString >> 2;
    NSLog(@"----2%ld",result2);
    
    
    School *sch = [[School alloc] init];
    NSLog(@"hash before :%ld",[sch hash]);
    NSLog(@"school address:%@",sch);
    if (sch.grade.stu.info) {
        NSLog(@"----yes----");
    }else {
        NSLog(@"----no----");
    }
    sch.grade.stu.info.name = @"wyb";
    NSLog(@"hash after :%ld",[sch hash]);
    
    NSLog(@"danmaku状态：%@",sch.danmakuVisible?@"yes":@"no");
    [sch config];
    NSLog(@"danmaku状态：%@",sch.danmakuVisible?@"yes":@"no");
}


#pragma mark - 算法

/// 适合有序数组
/// @param arr arr description
/// @param k k description
- (NSString *)findNumber:(NSArray *)arr k:(NSNumber *)k {
    // Write your code here
    NSInteger min = 0;
    NSInteger max = arr.count - 1;
    NSInteger mid = 0;
    while (min <= max) {
        mid = (min + max) >> 1;
        NSNumber *tempNum = [arr objectAtIndex:mid];
        if ([tempNum isKindOfClass:[NSNumber class]]) {
            if (k.integerValue > tempNum.integerValue) {
                min = mid + 1;
            }else if (k.integerValue < tempNum.integerValue) {
                max = mid -1;
            }else {
                return @"YES";
            }
        }
    }
    return @"NO";
}

@end
