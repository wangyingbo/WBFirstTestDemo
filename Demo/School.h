//
//  School.h
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import <Foundation/Foundation.h>
#import "Grade.h"


NS_ASSUME_NONNULL_BEGIN

@interface School : NSObject
@property (nonatomic, strong) Grade *grade;
@property (nonatomic, assign, readonly) BOOL danmakuVisible;

- (void)config;

@end

NS_ASSUME_NONNULL_END
