//
//  UIImage+Scale.h
//  Demo
//
//  Created by yingbo5 on 2021/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Scale)
// 根据 aSize 返回一个新的image
- (UIImage *)drawImageBySize:(CGSize)aSize;
@end

NS_ASSUME_NONNULL_END
