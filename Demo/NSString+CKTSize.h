//
//  NSString+CKTSize.h
//  Pods
//
//  Created by LiuYuxi on 15/11/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CKTSize)

- (CGSize)ckt_sizeWithFont:(UIFont *)font;
- (CGSize)ckt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)ckt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)ckt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (CGSize)ckt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
