//
//  Student.h
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import <Foundation/Foundation.h>
#import "WBInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (nonatomic, strong) WBInfo *info;
@property (nonatomic, copy) NSString *name;

+ (instancetype)createWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
