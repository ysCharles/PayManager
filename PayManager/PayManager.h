//
//  PayManager.h
//  PayManager
//
//  Created by Charles on 2018/4/13.
//  Copyright © 2018 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PayCompletion)(NSDictionary *resultDic);

/// 调起支付宝支付通知
extern NSString * const CallAlipayNotificationKey;
/// 支付结果通知
extern NSString * const AlipayResultNotificationKey;
/// 订单信息的 key
extern NSString * const OrderSignKey;

@interface PayManager : NSObject

/**
 获取单例

 @return 支付管理器
 */
+ (PayManager *)shareInstance;

/**
 注册支付宝支付后回到 app 的 scheme 需要和 URLScheme 中定义的一样
 */
- (void)registerScheme:(NSString *)scheme;

- (void)alipayProcessOrderWithURL:(NSURL *)url;
@end
