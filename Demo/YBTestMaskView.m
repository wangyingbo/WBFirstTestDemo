//
//  YBTestMaskView.m
//  Demo
//
//  Created by yingbo5 on 2022/6/30.
//

#import "YBTestMaskView.h"
#import "NSString+CKTSize.h"

@interface YBTestLevel1View ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *level1Label;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *topLayer;
@end
@implementation YBTestLevel1View
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.level1Label];
        //self.layer.mask = self.shapeLayer;//父控件的mask
        [self.layer addSublayer:self.topLayer];
        self.level1Label.layer.mask = self.shapeLayer;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    CGFloat width = CGRectGetWidth(self.frame);
    CGSize level1Size = [self _textSize];
    self.level1Label.frame = CGRectMake(width/2 - level1Size.width/2, CGRectGetHeight(self.frame)/2 - level1Size.height/2, level1Size.width, level1Size.height);
    //self.shapeLayer.frame = self.level1Label.frame;//父控件的mask
    self.shapeLayer.frame = self.level1Label.bounds;
    self.topLayer.frame = self.level1Label.frame;
}

- (UILabel *)level1Label {
    if (!_level1Label) {
        _level1Label = [[UILabel alloc] initWithFrame:CGRectZero];
        _level1Label.textColor = [UIColor redColor];
        _level1Label.font = [self _labelFont];
        _level1Label.textAlignment = NSTextAlignmentCenter;
        _level1Label.numberOfLines = 0;
        _level1Label.text = [self _text];
        
    }
    return _level1Label;
}


- (NSString *)_text {
    return @"pont 在法语中是“桥”的意思，寓意着前后端之间的桥梁。Pont 把 swagger、rap、dip 等多种接口文档平台，转换成 Pont 元数据。Pont 利用接口元数据，可以高度定制化生成前端接口层代码，接口 mock 平台和接口测试平台。其中 swagger 数据源，Pont 已经完美支持。并在一些大型项目中使用了近两年，各种高度定制化需求都可以满足。";
}

- (UIFont *)_labelFont {
    return [UIFont systemFontOfSize:15.f];
}

- (CGSize)_textSize {
    CGFloat width = CGRectGetWidth(self.frame);
    CGSize size = [[self _text] ckt_sizeWithFont:[self _labelFont] forWidth:width];
    return size;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        CGSize size = [self _textSize];
        CGFloat w = 75.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
        UIBezierPath *pathCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:w/2 startAngle:0 endAngle:2*M_PI clockwise:NO];
        [path appendPath:pathCircle];
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.path = path.CGPath;
        //mask 填不上颜色
//        _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
//        _shapeLayer.fillColor = [UIColor colorWithWhite:1 alpha:.5].CGColor;
        
    }
    return _shapeLayer;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        CGSize size = [self _textSize];
        CGFloat w = 75.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
        UIBezierPath *pathCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:w/2 startAngle:0 endAngle:2*M_PI clockwise:NO];
        [path appendPath:pathCircle];
        _topLayer = [CAShapeLayer layer];
        _topLayer.path = pathCircle.CGPath;
        _topLayer.fillColor = [UIColor blueColor].CGColor;
    }
    return _topLayer;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"gao.jpg"];
    }
    return _imageView;
}

@end


@interface YBTestMaskView ()
@property (nonatomic, strong) YBTestLevel1View *level1View;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

static CGFloat kLeftPadding = 25.f;
@implementation YBTestMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0. alpha:.1f];
        [self addSubview:self.level1View];
        //self.layer.mask = self.gradientLayer;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.level1View.frame = CGRectInset(self.bounds, kLeftPadding, kLeftPadding);
    self.gradientLayer.frame = self.bounds;
}

- (YBTestLevel1View *)level1View {
    if (!_level1View) {
        _level1View = [[YBTestLevel1View alloc] initWithFrame:CGRectInset(self.bounds, kLeftPadding, kLeftPadding)];
    }
    return _level1View;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        CAGradientLayer *maskLayer = [CAGradientLayer layer];
        maskLayer.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.f].CGColor, (id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor];
        maskLayer.locations = @[@0.0, @0.5];
        maskLayer.startPoint = CGPointMake(0, .5);
        maskLayer.endPoint = CGPointMake(1, .5);
        _gradientLayer = maskLayer;
    }
    return _gradientLayer;
}
@end
