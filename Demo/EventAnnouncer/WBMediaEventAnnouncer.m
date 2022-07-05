//
//  WBMediaEventAnnouncer.m
//  WBMediaAnalytics
//
//  Created by Wu Tian on 10/29/20.
//

#import "WBMediaEventAnnouncer.h"
#import "WBMediaEventAnnouncer+SubClass.h"

@interface WBMediaEventAnnouncer ()
{
    NSHashTable * _listeners;
    BOOL _requiresThreadSafety;
}

@end

@implementation WBMediaEventAnnouncer

- (instancetype)init
{
    if (self = [super init]) {
        _listeners = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        _requiresThreadSafety = [self requiresThreadSafety];
    }
    return self;
}

- (void)_addListener:(id)listener
{
    if (_requiresThreadSafety) {
        [self _threadSafeAddListener:listener];
    }
    else {
        [_listeners addObject:listener];
    }
}

- (void)_removeListener:(id)listener
{
    if (_requiresThreadSafety) {
        [self _threadSafeRemoveListener:listener];
    }
    else {
        [_listeners removeObject:listener];
    }
}

- (void)_enumerateListeners:(void (^)(id, NSUInteger))block
{
    if (_requiresThreadSafety) {
        [self _threadSafeEnumerateListeners:block];
    }
    else {
        if (!block) {
            return;
        }
        
        NSUInteger idx = 0;
        for (id listener in [_listeners allObjects]) {
            block(listener, idx);
            idx++;
        }
    }
}

- (BOOL)requiresThreadSafety
{
    return NO;
}

- (void)_threadSafeAddListener:(id)listener
{
    @synchronized (self) {
        [_listeners addObject:listener];
    }
}

- (void)_threadSafeRemoveListener:(id)listener
{
    @synchronized (self) {
        [_listeners removeObject:listener];
    }
}

- (void)_threadSafeEnumerateListeners:(void (^)(id, NSUInteger))block
{
    if (!block) {
        return;
    }
    
    NSUInteger idx = 0;
    NSArray *tempListeners;
    @synchronized (self) {
        tempListeners = [_listeners allObjects];
    }
    for (id listener in tempListeners) {
        block(listener, idx);
        idx++;
    }
}

@end
