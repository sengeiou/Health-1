//
//  AdsRequest.swift
//  Health
//
//  Created by Yalin on 15/8/18.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

struct RequestLoginAdModel {
    let imageURL: String
    let linkURL: String
    
    var serverImageURL: String {
        return Request.requestPHPPathURL() + imageURL
    }
}

struct AdsRequest {
    
    
    static func queryLaunchAds(complete: ((ad: RequestLoginAdModel?, error: NSError?) -> Void)) {
        
        RequestType.QueryLaunchAds.startRequest([:], completionHandler: { (data, response, error) -> Void in
            let result = Request.dealResponseData(data, response: response, error: error)
            if let err = result.error {
                complete(ad: nil, error: err)
                #if DEBUG
                    println("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
                #endif
            }
            else {
                let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                complete(ad: RequestLoginAdModel(imageURL: jsonObj!.valueForKey("imageURL") as! String, linkURL: jsonObj!.valueForKey("targetURL") as! String), error: nil)
                #if DEBUG
                    println("\n----------\n\(#function) \nresult \(jsonObj)\n==========")
                #endif
            }
        })
    }
    
    static func queryActivityAds(userId: Int, complete: ((ads: [RequestLoginAdModel]?, error: NSError?) -> Void)) {
        RequestType.QueryActivityAds.startRequest(["userId" : userId], completionHandler: { (data, response, error) -> Void in
            let result = Request.dealResponseData(data, response: response, error: error)
            if let err = result.error {
                complete(ads: nil, error: err)
                #if DEBUG
                    println("\n----------\n\(#function) \nerror:\(err.localizedDescription)\n==========")
                #endif
            }
            else {
                let jsonObj: NSDictionary? = result.jsonObj as? NSDictionary
                
                let ads = jsonObj?.valueForKey("ads") as? [[String : String]]
                
                var adModels: [RequestLoginAdModel] = []
                for adInfo: [String : String] in ads! {
                    adModels += [RequestLoginAdModel(imageURL: adInfo["imageURL"]!, linkURL: adInfo["targetURL"]!)]
                }
                complete(ads: adModels, error: nil)
                #if DEBUG
                    println("\n----------\n\(#function) \nresult \(jsonObj)\n==========")
                #endif
            }
        })
    }
}
