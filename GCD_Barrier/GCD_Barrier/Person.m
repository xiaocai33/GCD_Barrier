//
//  Person.m
//  GCD_Barrier
//
//  Created by 小蔡 on 16/9/13.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "Person.h"

static NSString *_name;
static dispatch_queue_t _queue;
@implementation Person

- (instancetype)init{
    if (self = [super init]) {
        _queue = dispatch_queue_create("xiaocai", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setName:(NSString *)name{
    dispatch_barrier_async(_queue, ^{
        _name = [name copy];
    });
}

- (NSString *)name{
    __block NSString *temp;
    dispatch_sync(_queue, ^{
        temp = _name;
    });
    return temp;
}


@end
