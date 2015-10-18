//
//  ScaleResultExtension.swift
//  Health
//
//  Created by Yalin on 15/10/10.
//  Copyright © 2015年 Yalin. All rights reserved.
//

import UIKit

func ScaleResultProtocolCreate(info: [String : AnyObject]) -> ScaleResultProtocol {
    let deviceType = (info["deviceType"] as! NSNumber).integerValue
    
    if deviceType == 0 {
        return MyBodyResult(info: info)
    }
    else if deviceType == 1 {
        return MyBodyMiniAndPlusResult(info: info)
    }
    else {
        return MyBodyResult(info: info)
    }
}


extension ScaleResultProtocol {
    
    func uploadInfo(timestamp: Int) -> [String: AnyObject] {
        
        var uploadInfo : [String: AnyObject] = [
            
            "userId" : userId,
            "boneWeight" : boneWeight,
            "boneMuscleWeight" : boneMuscleWeight,
            "fatPercentage" : fatPercentage,
            "fatWeight" : fatWeight,
            "muscleWeight" : muscleWeight,
            "proteinWeight" : proteinWeight,
            "visceralFatPercentage" : visceralFatPercentage,
            "waterPercentage" : waterPercentage,
            "waterWeight" : waterWeight,
            "weight" : weight,
            "timeStamp" : timestamp
        ]
        
        uploadInfo["bmi"] = BMI
        uploadInfo["bmiMax"] = BMIRange.1
        uploadInfo["bmiMin"] = BMIRange.0
        uploadInfo["bmr"] = BMR
        uploadInfo["bodyAge"] = bodyAge
        uploadInfo["boneMuscleWeightMax"] = boneMuscleRange.1
        uploadInfo["boneMuscleWeightMin"] = boneMuscleRange.0
        uploadInfo["boneWeightMax"] = boneWeightRange.1
        uploadInfo["boneWeightMin"] = boneWeightRange.0
        uploadInfo["fatControl"] = fatControl
        uploadInfo["fatFreeBodyWeight"] = fatFreeBodyWeight
        uploadInfo["fatFreeBodyWeightMax"] = fatFreeBodyWeightRange.1
        uploadInfo["fatFreeBodyWeightMin"] = fatFreeBodyWeightRange.0
        uploadInfo["fatPercentageMax"] = fatPercentageRange.1
        uploadInfo["fatPercentageMin"] = fatPercentageRange.0
        uploadInfo["fatWeightMax"] = fatWeightRange.1
        uploadInfo["fatWeightMin"] = fatWeightRange.0
        uploadInfo["goalWeight"] = goalWeight
        if hepaticAdiposeInfiltration == nil {
            uploadInfo["hepaticAdiposeInfiltration"] = 0
        }
        else {
            uploadInfo["hepaticAdiposeInfiltration"] = hepaticAdiposeInfiltration! ? 1 : 0
        }
        uploadInfo["leftLowerExtremityBone"] = leftLowerExtremityBone
        uploadInfo["leftLowerExtremityFat"] = leftLowerExtremityFat
        uploadInfo["leftLowerExtremityMuscle"] = leftLowerExtremityMuscle
        uploadInfo["leftUpperExtremityBone"] = leftUpperExtremityBone
        uploadInfo["leftUpperExtremityFat"] = leftUpperExtremityFat
        uploadInfo["leftUpperExtremityMuscle"] = leftUpperExtremityMuscle
        uploadInfo["muscleControl"] = muscleControl
        uploadInfo["m_smm"] = m_smm
        uploadInfo["muscleWeightMax"] = muscleWeightRange.1
        uploadInfo["muscleWeightMin"] = muscleWeightRange.0
        uploadInfo["proteinWeightMax"] = proteinWeightRange.1
        uploadInfo["proteinWeightMin"] = proteinWeightRange.0
        uploadInfo["rightLowerExtremityBone"] = rightLowerExtremityBone
        uploadInfo["rightLowerExtremityFat"] = rightLowerExtremityFat
        uploadInfo["rightLowerExtremityMuscle"] = rightLowerExtremityMuscle
        uploadInfo["rightUpperExtremityBone"] = rightUpperExtremityBone
        uploadInfo["rightUpperExtremityFat"] = rightUpperExtremityFat
        uploadInfo["rightUpperExtremityMuscle"] = rightUpperExtremityMuscle
        uploadInfo["score"] = score
        
        uploadInfo["sw"] = SW
        uploadInfo["swMax"] = SWRange.1
        uploadInfo["swMin"] = SWRange.0
        uploadInfo["trunkLimbBone"] = trunkLimbBone
        uploadInfo["trunkLimbFat"] = trunkLimbFat
        uploadInfo["trunkLimbMuscle"] = trunkLimbMuscle
        uploadInfo["waterWeightMax"] = waterWeightRange.1
        uploadInfo["waterWeightMin"] = waterWeightRange.0
        uploadInfo["weightControl"] = weightControl
        uploadInfo["whr"] = WHR
        uploadInfo["whrMax"] = WHRRange.1
        uploadInfo["whrMin"] = WHRRange.0
        uploadInfo["externalMoisture"] = externalMoisture
        uploadInfo["internalMoisture"] = internalMoisture
        uploadInfo["edemaFactor"] = edemaFactor
        uploadInfo["obesity"] = obesity
        
        return uploadInfo
    }
}

// 创建结果
extension ScaleResultProtocol {
    
    
}

// MARK: - 计算属性
extension ScaleResultProtocol {
    
    // 体重范围
    var weightRange: (Float, Float) {
        get {
            return (0.9 * SW, 1.1 * SW)
        }
        set {
            
        }
    }
    
    // 内脏脂肪范围
    var visceralFatContentRange: (Float, Float) {
        get {
            return (10, 5.5)
        }
        set {
            
        }
    }
    
    // 去脂体重
    var LBM: Float {
        get {
            return (SW + 0.5684) / (1 - 0.0537)
        }
        set {
            
        }
    }
    
    // 标准体脂率
    var standardFatPercentage: Float {
        get {
            return gender ? 15 : 25
        }
        set {
            
        }
    }
    
    // 每日需消耗卡路里
    var dayNeedCalorie: Float {
        if gender {
            // 男
            if weight <= 60 {
                return 2030
            }
            else if weight <= 70 {
                return 2030
            }
            else if weight <= 80 {
                return 2370
            }
            else if weight <= 90 {
                return 2710
            }
            else {
                return 3050
            }
        }
        else {
            // 女
            if weight <= 50 {
                return 1520
            }
            else if weight <= 55 {
                return 1520
            }
            else if weight <= 60 {
                return 1680
            }
            else if weight <= 65 {
                return 1830
            }
            else {
                return 1980
            }
        }
    }
}

// MARK: - 等级判断
extension ScaleResultProtocol {
    
    var waterWeightStatus: ValueStatus {
        return ValueStatus(value: waterWeight, low: waterWeightRange.0, high: waterWeightRange.1)
    }
    
    var proteinWeightStatus: ValueStatus {
        return ValueStatus(value: proteinWeight, low: proteinWeightRange.0, high: proteinWeightRange.1)
    }
    
    var boneWeightStatus: ValueStatus {
        return ValueStatus(value: boneWeight, low: boneWeightRange.0, high: boneWeightRange.1)
    }
    
    var weightStatus: ValueStatus {
        return ValueStatus(value: weight, low: weightRange.0, high: weightRange.1)
    }
    var weightStatusDescription: String {
        return WeightStatus(fatPercentage: fatPercentage, gender: gender).description
    }
    
    var fatWeightStatus: ValueStatus {
        return ValueStatus(value: fatWeight, low: fatWeightRange.0, high: fatWeightRange.1)
    }
    
    var muscleWeightStatus: ValueStatus {
        return ValueStatus(value: muscleWeight, low: muscleWeightRange.0, high: muscleWeightRange.1)
    }
    
    var boneMuscleLevel: ValueStatus {
        if gender {
            return ValueStatus(value: boneMuscleWeight, low: 0.75 * 0.9 * m_smm * 0.82, high: 0.75 * 1.1 * m_smm * 0.82)
        }
        else {
            return ValueStatus(value: boneMuscleWeight, low: 0.75 * 0.9 * m_smm * 0.77, high: 0.75 * 1.1 * m_smm * 0.77)
        }
    }
    
    var visceralFatContentStatus: ValueStatus {
        
        /*内脏脂肪指数判定 0.5-5.5 		正常 5.5-10 		超标 10以上 		高*/
        let status = ValueStatus(value: visceralFatPercentage, low: visceralFatContentRange.0, high: visceralFatContentRange.1)
        if status == .Low {
            return .Normal
        }
        else if status == .Normal {
            return .Low
        }
        else {
            return .High
        }
    }
    
    var fatPercentageStatus: ValueStatus {
        return ValueStatus(value: fatPercentage, low: fatPercentageRange.0, high: fatPercentageRange.1)
    }
    
    var BMIStatus: ValueStatus {
        return ValueStatus(value: BMI, low: BMIRange.0, high: BMIRange.1)
    }
}

// MARK: - 评分计算
extension ScaleResultProtocol {
    
}

// MARK: - 体型
extension ScaleResultProtocol {
    // 体型
    var physique: Physique {
        return Physique(gender: gender, fatPercentage: fatPercentage, BMI: BMI)
    }
}



