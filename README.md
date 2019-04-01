# PayManager

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/PayManager.svg?style=flat)](https://github.com/ysCharles/PayManager)
[![Build Status](https://travis-ci.org/ysCharles/PayManager.svg?branch=master)](https://travis-ci.org/ysCharles/PayManager)
[![Swift Version Compatibility](https://img.shields.io/badge/swift5-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![swiftyness](https://img.shields.io/badge/pure-swift-ff3f26.svg?style=flat)](https://swift.org/)
[![Swift Version](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://swift.org)
[![GitHub stars](https://img.shields.io/github/stars/ysCharles/PayManager.svg)](https://github.com/ysCharles/PayManager/stargazers)



## Installation

### Carthage

```ruby
github "ysCharles/PayManager"
```

Cartfile添加上面之后，执行`carthage update --platform iOS`,然后在target→Build Phases→Run Script 的 inputfile 和 outputfile 中分别添加

`input file`

```
$(SRCROOT)/Carthage/Build/iOS/PayManager.framework
```

`outpu file`

```
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/PayManager.framework
```



## Usage

* target→Build Phases→Link Binary With Libraries 中 `+`PayManager.framework

* target→Info→URL Types中添加一个 URLSchemes 填写字符串 例如：WXGCPay

* 最后在 Appdelegate 中添加注册

  ```objective-c
  #import <PayManager/PayManager.h>
  @implementation AppDelegate
  
  
  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      // 必须注册 不然  付款后 无法返回到 app
      [[PayManager shareInstance] registerScheme:@"WXGCPay"]; //这里与上面 URLTypes里添加的 URL schemes对应
      // ...
      return YES;
  }
  
  // NOTE: 9.0之前使用
  - (BOOL)application:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
      
      if ([url.host isEqualToString:@"safepay"]) {
          //跳转支付宝钱包进行支付，处理支付结果
          [[PayManager shareInstance] alipayProcessOrderWithURL:url];
      }
      return YES;
  }
  
  // NOTE: 9.0以后使用新API接口
  - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
  {
      if ([url.host isEqualToString:@"safepay"]) {
          //跳转支付宝钱包进行支付，处理支付结果
          [[PayManager shareInstance] alipayProcessOrderWithURL:url];
  
      }
      return YES;
  }
  
  @end
  ```

  

* 调起支付，通过通知的方式调起

  ```swift
  @IBAction func pay(_ sender: Any) {
          
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PayManager_Call_Alipay_Notification_Key"), object: nil, userInfo: ["signKey" : "支付字符串"])
      }
  ```

  

  

  