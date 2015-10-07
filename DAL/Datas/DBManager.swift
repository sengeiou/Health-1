//
//  DBManager.swift
//  Health
//
//  Created by Yalin on 15/8/14.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import Foundation

protocol DBUserProtocol {
    func queryAllUser() -> [[String: NSObject]]
    func addUser(setDatas:(inout setDatas: UserDBData)-> UserDBData)
    func deleteUser(userId: UInt8)
}

protocol DBEvaluationProtocol {
    func addEvaluationData(setDatas:(inout setDatas: EvaluationData)-> EvaluationData)
    func deleteEvaluationData(dataId: String, userId: Int)
    func queryEvaluationData(dataId: String, userId: Int) -> [String: AnyObject]?
    func queryEvaluationDatas(beginTimescamp: NSDate, endTimescamp: NSDate, userId: Int) -> [[String: AnyObject]]
    func queryNoUploadEvaluationDatas() -> [[String: AnyObject]]
    func updateUploadEvaluationDatas(newDataIdInfos: [[String: AnyObject]])
    func queryLastEvaluationData(userId: Int) -> [String: AnyObject]?
}

protocol DBGoalProtocol {
    func addGoalData(setDatas:(inout setDatas: GoalData)-> GoalData)
    func deleteGoalData(dataId: String)
    func queryGoalData(dataId: String) -> [String: NSObject]?
    func queryLastGoalData() -> [String: NSObject]?
    func queryGoalData(beginDate: NSDate, endDate: NSDate) -> [[String: NSObject]]
}

protocol DBDeviceProtocol {
    
    func haveConnectedWithType(type: DeviceType) -> Bool
    var haveConnectedScale: Bool { get }
    var haveConnectedBracelet: Bool { get }
    func braceletInfo() -> (uuid: String, name: String)?
    func addDevice(uuid: String, name: String, type: DeviceType)
}

protocol DBManagerProtocol : DBUserProtocol, DBEvaluationProtocol, DBGoalProtocol, DBDeviceProtocol {
    func saveContext()
}

class DBManager {
    
    var userId: String?
    
    class func shareInstance() -> DBManager {
        struct YYSingle {
            static var predicate: dispatch_once_t = 0
            static var instance: DBManager? = nil
        }
        
        dispatch_once(&YYSingle.predicate, { () -> Void in
            YYSingle.instance = DBManager()
        })
        
        return YYSingle.instance!
    }
    
    init() {
        userId = "\(UserData.shareInstance().userId!)"
    }
}