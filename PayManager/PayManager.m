//
//  PayManager.m
//  PayManager
//
//  Created by Charles on 2018/4/13.
//  Copyright © 2018 Charles. All rights reserved.
//

#import "PayManager.h"
#import <AlipaySDK/AlipaySDK.h>
@implementation PayManager
+ (void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr callback:(void(^)(NSDictionary *))callback {
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:schemeStr callback:^(NSDictionary *resultDic) {
        callback(resultDic);
    }];
}

+ (void)processOrderWithPaymentResult:(NSURL *)resultUrl standbyCallback:(void(^)(NSDictionary *))completionBlock {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:resultUrl standbyCallback:^(NSDictionary *resultDic) {
        completionBlock(resultDic);
    }];
}
@end
