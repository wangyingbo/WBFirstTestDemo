//
//  WBMediaEventAnnouncer+SubClass.h
//  WBMediaAnalytics
//
//  Created by Wu Tian on 10/29/20.
//

#import "WBMediaEventAnnouncer.h"

@interface WBMediaEventAnnouncer ()

- (void)_addListener:(id)listener;
- (void)_removeListener:(id)listener;

- (void)_enumerateListeners:(void (^)(id listener, NSUInteger idx))block;

- (BOOL)requiresThreadSafety;

@end
