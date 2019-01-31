//
//  ViewController.m
//  RacTest
//
//  Created by 宋宏康 on 2019/1/26.
//  Copyright © 2019 demo. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()
@property (nonatomic, strong) RACCommand *command;
@property (nonatomic, strong) RACSubject *subject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)cooltoHotDemo6
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signal1"];
        [subscriber sendNext:@"signal2"];
        return nil;
    }];
    RACSignal *rplaSignal = [signal replayLast];
    [rplaSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)cooltoHotDemo5
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signal1"];
        [subscriber sendNext:@"signal2"];
        return nil;
    }];
    RACSignal *rplaSignal = [signal replayLazily];
    [rplaSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }]; // rplaSignal 被订阅时 才会执
}

- (void)replayDemo
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        static int i = 0;
        i++;
        [subscriber sendNext: [NSString stringWithFormat:@"%d",i]];
        return nil;
    }] replay];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)cooltoHotDemo4
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"hongkang.song"];
        [subscriber sendNext:@"hongkang.song"];
        return nil;
    }];
    
    [[signal replay] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)cooltoHotDemo3
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"hongkang.song"];
        return nil;
    }];
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [connection connect];
}

- (void)cooltoHotDemo2
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signal"];
        return nil;
    }];
    RACSubject *subject = [RACSubject subject];
    RACMulticastConnection *connect = [signal multicast:subject];
    /// connect.sinal 就是subject
    /// connect.
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [connect connect];
    
}

- (void)cooltoHotDemo1
{
    // 冷信号转热信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"111"];
        return nil;
    }];
    
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [signal subscribe:subject];
}

- (void)demo
{
    //    NSArray *arr = @[@1,@2,@3];
    //    [[arr.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
    //        return @1;
    //    }] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    
    //    RACSubject *subject = [RACSubject subject];
    //
    //    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    //
    //        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //
    //            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:121 userInfo:@{NSLocalizedDescriptionKey:@"本地化的错误描述"}];
    //            [subscriber sendError:error];
    //            return nil;
    //        }];
    //    }];
    //    self.command = command;
    //    [command execute:@1];
    
    
    //    [command.errors subscribeNext:^(NSError * _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    //    [command.errors subscribe:<#(nonnull id<RACSubscriber>)#>
    //
    //    [subject subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"===========");
    //        NSLog(@"%@",x);
    //    }];
    //
}
@end
