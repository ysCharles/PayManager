//
//  ViewController.swift
//  PayManagerDemo
//
//  Created by Charles on 2018/4/13.
//  Copyright © 2018 Charles. All rights reserved.
//

import UIKit
import PayManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(payResult(notification:)), name: NSNotification.Name(rawValue: "PayManager_Alipay_Result_Notification_key"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var payClick: UIButton!
    
    @IBAction func pay(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PayManager_Call_Alipay_Notification_Key"), object: nil, userInfo: ["signKey" : "alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018033002473310&biz_content=%7B%22body%22%3A%22%E5%A4%AA%E6%B9%96%E9%BC%8B%E5%A4%B4%E6%B8%9A-%E6%88%90%E4%BA%BA%E7%A5%A8-OD20180413191807000081%22%2C%22out_trade_no%22%3A%22CS20180413191809000272%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22%E5%A4%AA%E6%B9%96%E9%BC%8B%E5%A4%B4%E6%B8%9A-%E6%88%90%E4%BA%BA%E7%A5%A8%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%2288.00%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Fts.wxlyykt.com%2Fpay%2Fbus%2Fpay%2FpayAlipayNotify&sign=EqdR5eXB4xt5FT%2FqCtHXx62YS94UTeRjHiTsEA7DFDgBmSONp51A3Z35%2BEulpJbuwnLjBsNOABsx%2B6boRHGUeo5tu9JKoykVAd50FND53j99mOD7Ye80aM1cnpG7iqphXHJf1fGpKw%2BM3U3581raY0ZxZLffcC7DDiWOvOdj7E3EDhQm%2F3y8Dz4iWpol0BsupEoWak3ByRjkDvwzHZ%2FDpGxkZwcSMIXx%2B2Ez94%2FItUTw3HUFmmFmheZ%2FjADSLOuWS2nJRxHhHtYkbE8kozIjP6nuLv15rSSjcgZSo%2FKYi4fwWBxyZH36M49mr4A67LkLcvmWVvnMxEEaCMc%2FdQHhaw%3D%3D&sign_type=RSA2&timestamp=2018-04-13+19%3A18%3A09&version=1.0"])
    }
    
    @objc private func payResult(notification: Notification) {
        if let userInfo = notification.userInfo {
            print(userInfo)
        }
    }
}

