//
//  School.m
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import "School.h"

@interface School ()
@property (nonatomic, assign) BOOL danmakuVisible;
@end

@implementation School

- (void)config {
    self.danmakuVisible = YES;
}

- (void)setDanmakuVisible:(BOOL)danmakuVisible {
    _danmakuVisible = danmakuVisible;
    NSLog(@"可以调用setDanmakuVisible:方法");
}
@end
