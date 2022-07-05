//
//  NSString+CKTSize.m
//  Pods
//
//  Created by LiuYuxi on 15/11/17.
//
//

#import "NSString+CKTSize.h"

@implementation NSString (CKTSize)


- (CGSize)ckt_sizeWithFont:(UIFont *)font
{
    return [self ckt_sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (CGSize)ckt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self ckt_sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)ckt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width
{
    return [self ckt_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
}

- (CGSize)ckt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self ckt_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode];
}


- (CGSize)ckt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (nil == font)
    {
        assert(0);
        return CGSizeZero;
    }
    
    NSMutableParagraphStyle* paragrap = [[NSMutableParagraphStyle alloc] init];
    paragrap.lineBreakMode = lineBreakMode;
    
    
    
    NSDictionary* attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragrap };
    
    CGRect stringBound = [self boundingRectWithSize:size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
    
    
    return CGSizeMake(ceil(stringBound.size.width), ceil(stringBound.size.height));
}


@end


















































