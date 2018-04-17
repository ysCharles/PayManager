//
//  PayManager.m
//  PayManager
//
//  Created by Charles on 2018/4/13.
//  Copyright © 2018 Charles. All rights reserved.
//

#import "PayManager.h"
#import <AlipaySDK/AlipaySDK.h>

NSString * const CallAlipayNotificationKey = @"PayManager_Call_Alipay_Notification_Key";
NSString * const AlipayResultNotificationKey = @"PayManager_Alipay_Result_Notification_key";
NSString * const OrderSignKey = @"signKey";

@interface PayManager()
@property (copy, nonatomic) NSString *scheme;
@end

@implementation PayManager

- (void)alipayProcessOrderWithURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self processResult:resultDic];
        }];
    }
}

- (void)registerScheme:(NSString *)scheme
{
    self.scheme = scheme;
}


#pragma mark - 单例
+ (PayManager *)shareInstance {
    static PayManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (singleton == nil) {
            singleton = [[PayManager alloc] init];
        }
    });
    
    return singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callAlipay:) name:CallAlipayNotificationKey object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 调起支付通知监听
/**
 监听发起支付宝支付的通知
 
 @param notification 内部有 signString  拿到这个字符串 直接发起支付请求
 */
- (void)callAlipay:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *signKey = [userInfo objectForKey:OrderSignKey];
    if (signKey) {
        [[AlipaySDK defaultService] payOrder:signKey fromScheme:self.scheme callback:^(NSDictionary *resultDic) {
            [self processResult:resultDic];
        }];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlipayResultNotificationKey object:nil userInfo:@{@"result": @"failure", @"msg" : @"支付参数错误，请重试~"}];
    }
}


#pragma mark - 处理 返回结果
- (void)processResult:(NSDictionary *)result {
    if (result) {
    
        NSString *resultStatus = [result objectForKey:@"resultStatus"];
        if (resultStatus) {
            if ([resultStatus isEqualToString:@"9000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:AlipayResultNotificationKey object:nil userInfo:@{@"result" : @"success", @"msg" : @"支付成功"}];
            } else if ([resultStatus isEqualToString:@"6001"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:AlipayResultNotificationKey object:nil userInfo:@{@"result" : @"cancel", @"msg" : @"取消支付"}];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:AlipayResultNotificationKey object:nil userInfo:@{@"result" : @"failure", @"msg" : @"支付失败，请重试~"}];
            }
            
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:AlipayResultNotificationKey object:nil userInfo:@{@"result": @"failure", @"msg" : @"支付失败，请重试~"}];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlipayResultNotificationKey object:nil userInfo:@{@"result": @"failure", @"msg" : @"支付失败，请重试~"}];
    }
}

@end
