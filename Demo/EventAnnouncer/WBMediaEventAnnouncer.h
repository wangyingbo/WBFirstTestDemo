//
//  WBMediaEventAnnouncer.h
//  WBMediaAnalytics
//
//  Created by Wu Tian on 10/29/20.
//

#if !__has_feature(modules)
#import <Foundation/Foundation.h>
#else
@import Foundation;
#endif

// 担心有性能问题，暂时先不使用 runtime 消息转发机制, 子类需通过 _SubClass 中的方法手动转发消息

@interface WBMediaEventAnnouncer : NSObject

@end
