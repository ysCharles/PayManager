//
//  PayManager.h
//  PayManager
//
//  Created by Charles on 2018/4/13.
//  Copyright © 2018 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PayCompletion)(NSDictionary *resultDic);

@interface PayManager : NSObject

+ (void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr callback:(void(^)(NSDictionary *))callback;
+ (void)processOrderWithPaymentResult:(NSURL*)resultUrl standbyCallback:(void(^)(NSDictionary *))completionBlock;
@end
