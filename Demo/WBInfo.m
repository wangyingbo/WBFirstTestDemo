//
//  WBInfo.m
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import "WBInfo.h"
#import <objc/runtime.h>

@implementation WBInfo

- (void)danmakuShow {
    NSLog(@"WBInfo 执行了  name:%@",self.name);
}
@end


@interface YBInfo ()
@property (nonatomic, assign) BOOL exec;
@end
@implementation YBInfo

- (void)config:(BOOL)exec {
    self.exec = exec;
    [self danmakuShow];
}
- (void)danmakuShow {
    
    if (self.exec) {
        NSLog(@"父类方法没有执行");
        return;
    }
    
    SEL selector = NSSelectorFromString(NSStringFromSelector(_cmd));
    IMP imp = [self.superclass instanceMethodForSelector:selector];
    void(*func)(id,SEL) = (void *)imp;
    if (func) { func(self,selector); }
    
//    Method method = class_getInstanceMethod(self.superclass, _cmd);
//    IMP imp = class_getMethodImplementation(self.superclass, _cmd);
//    void (*func)(id,Method) = (void *)imp;
//    func(self,method);
}


@end
