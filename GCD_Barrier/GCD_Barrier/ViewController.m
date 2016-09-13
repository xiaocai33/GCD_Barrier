//
//  ViewController.m
//  GCD_Barrier
//
//  Created by 小蔡 on 16/9/13.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrM = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self addObjc:@"张三"];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self addObjc:@"小明"];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self addObjc:@"小蔡"];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self addObjc:@"浏览"];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self readArray];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self addObjc:@"朝气"];
    });
    
}

- (void)addObjc:(NSString *)str{
    if (str){
        NSLog(@"添加数组--%@", str);
        [self.arrM addObject:str];
    }
}

- (void)readArray{
    NSLog(@"个数--%zd--%@", self.arrM.count, self.arrM);
    
    for(NSString *str in self.arrM){
        NSLog(@"名字--%@", str);
    }
    
//    [self.arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"数组元素--%@", obj);
//    }];
}

@end
