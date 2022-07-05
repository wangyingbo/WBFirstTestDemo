//
//  UIImage+Scale.m
//  Demo
//
//  Created by yingbo5 on 2021/7/8.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)
/**
 * 压缩图片使图片文件小于指定大小
 * @param maxLength  压缩最大长度
 */
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength
{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    if (data.length > maxLength) {
        UIImage *nImage = [self drawImageBySize:CGSizeMake(self.size.width*0.5, self.size.height*0.5)];
        data = [nImage compressQualityWithMaxLength:maxLength];
    }
    
    return data;
}


// 根据 aSize 返回一个新的image
- (UIImage *)drawImageBySize:(CGSize)aSize {
    UIGraphicsBeginImageContext(aSize);
    [self drawInRect:CGRectMake(0, 0, aSize.width, aSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
