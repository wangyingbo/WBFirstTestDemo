//
//  WBInfo.h
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBInfo : NSObject
@property (nonatomic, copy) NSString *name;
@end

@interface YBInfo : WBInfo
@property (nonatomic, strong) WBInfo *retainInfo;
- (void)config:(BOOL)exec;
@end

NS_ASSUME_NONNULL_END
