//
//  ActivityManager.swift
//  Health
//
//  Created by Yalin on 15/8/20.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import Foundation

struct ActivityManager {
    static func queryActiveAds(complete: ((ads: [RequestLoginAdModel]?, error: NSError?) -> Void)) {
        AdsRequest.queryActivityAds(UserData.shareInstance().userId!, complete: complete)
    }
}