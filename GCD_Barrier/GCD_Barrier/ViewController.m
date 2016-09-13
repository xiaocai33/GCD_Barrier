//
//  ViewController.m
//  GCD_Barrier
//
//  Created by 小蔡 on 16/9/13.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *arrM;
@end


static dispatch_queue_t _queue;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc] init];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        p.name = @"张三";
    });
    
    dispatch_async(globalQueue, ^{
        NSLog(@"%@", p.name);
    });
    
    dispatch_async(globalQueue, ^{
        p.name = @"李四";
    });
    _queue = dispatch_queue_create("hah", DISPATCH_QUEUE_CONCURRENT);
    
    [self test];
    
    
}

- (void)test{
    self.arrM = [NSMutableArray array];
    [self addObjc:@"张三"];
    [self addObjc:@"小明"];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    //读取数组(读操作)
    dispatch_async(globalQueue, ^{
        //block();
        [self readArray];
    });
    
    //读取数组(读操作)
    dispatch_async(globalQueue, ^{
        //block();
        [self readArray];
    });
    
    //读取数组(读操作)
    dispatch_async(globalQueue, ^{
        //block();
        [self readArray];
    });
    
    //读取数组(读操作)
    dispatch_async(globalQueue, ^{
        //block();
        [self readArray];
    });
    
    
    //添加元素(写操作)
    dispatch_async(globalQueue, ^{
        [self addObjc:@"接啊开发"];
    });
    
    //读取数组(读操作)
    dispatch_async(globalQueue, ^{
        //block();
        [self readArray];
    });
    
    //读取数组(读操作)
    dispatch_async(globalQueue, ^{
        //block();
        [self readArray];
    });
    

}

//写操作
- (void)addObjc:(NSString *)str{
    //写操作要保证读操作完成
    dispatch_barrier_async(_queue, ^{
        if (str){
            NSLog(@"添加数组--%@", str);
            [self.arrM addObject:str];
        }
    });
    
}

//读操作
- (void)readArray{
    //读操作可以并行的
    dispatch_sync(_queue, ^{
        NSLog(@"个数--%zd", self.arrM.count);
        
        for(NSString *str in self.arrM){
            NSLog(@"名字--%@", str);
        }
    });
    
}

@end
