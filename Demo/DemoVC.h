//
//  DemoVC.h
//  Demo
//
//  Created by yingbo5 on 2021/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DemoVCProtocol <NSObject>

@end

@interface DemoVC : UIViewController

@property (nonatomic, copy) NSString *testString;

@end

NS_ASSUME_NONNULL_END
