//
//  GoalViewController.swift
//  Health
//
//  Created by Yalin on 15/8/20.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController {

    var viewModel = GoalViewModel()
    
    @IBOutlet weak var userSelectView: UserSelectView!
    @IBOutlet weak var goalDetailLabel: AttributedLabel!
    @IBOutlet weak var suggestCalorieLabel: AttributedLabel!
    
    @IBOutlet weak var connectDeviceView: UIView!
    @IBOutlet weak var sportDetailLabel: AttributedLabel!
    @IBOutlet weak var sleepDetailLabel: AttributedLabel!
    
    @IBOutlet weak var noDeviceView: UIView!
    @IBOutlet weak var noDeviceDetailLabel: AttributedLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true
        
        if !GoalManager.isSetGoal {
            let controller = GoalSettingViewController()
            AppDelegate.rootNavgationViewController().pushViewController(controller, animated: true)
        }
        
        showView(GoalManager.isConnectDevice() ? connectDeviceView : noDeviceView)
        userSelectView.setChangeButton(true)
        userSelectView.setUsers(UserManager.shareInstance().queryAllUsers(), isNeedExt: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if GoalManager.isConnectDevice() {
            GoalManager.syncDatas({ [unowned self] (error: NSError?) -> Void in
                if self.respondsToSelector(Selector("refreshView")) {
                    self.refreshView()
                }
            })
        }
        
        setGoalDetail()
        setSuggestCalorie()
        setConnectDevice()
        setNoDeviceView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - set View
    func refreshView() {
        
        showView(GoalManager.isConnectDevice() ? connectDeviceView : noDeviceView)
        setGoalDetail()
        setSuggestCalorie()
        setConnectDevice()
        setNoDeviceView()
    }
    
    func setGoalDetail() {
        
        goalDetailLabel.clear()
        if GoalManager.isSetGoal {
            goalDetailLabel.append("您当前设定的目标是", font: nil, color: deepBlue)
            goalDetailLabel.append(" \(UserGoalData.type.description())\n", font: nil, color: lightBlue)
            
            
            if let showInfo = GoalManager.currentGoalInfo() {
                
                goalDetailLabel.append("剩余", font: nil, color: deepBlue)
                goalDetailLabel.append(" \(UserGoalData.restDays!) ", font: nil, color: lightBlue)
                
                if showInfo.addFatPercentage > 0 {
                    goalDetailLabel.append("天,还需增加", font: nil, color: deepBlue)
                    goalDetailLabel.append(" \(abs(showInfo.addFatPercentage))% ", font: nil, color: lightBlue)
                    goalDetailLabel.append("体脂率", font: nil, color: deepBlue)
                }
                else {
                    goalDetailLabel.append("天,还需降低", font: nil, color: deepBlue)
                    goalDetailLabel.append(" \(abs(showInfo.addFatPercentage))% ", font: nil, color: lightBlue)
                    goalDetailLabel.append("体脂率", font: nil, color: deepBlue)
                }
            }
            else {
                goalDetailLabel.append("您还没有使用体重秤评测过,请先评测", font: nil, color: deepBlue)
            }
        }
        else {
            goalDetailLabel.append("您还没有设置目标,请先设置目标", font: nil, color: deepBlue)
        }
    }
    
    func setSuggestCalorie() {
        suggestCalorieLabel.clear()
        if GoalManager.isSetGoal {
            if let showInfo = GoalManager.currentGoalInfo() {
                suggestCalorieLabel.append("建议每天摄入热量", font: nil, color: deepBlue)
                suggestCalorieLabel.append("\(showInfo.dayCalorieGoal) kcal", font: nil, color: lightBlue)
            }
            else {
                suggestCalorieLabel.append("您还没有使用体重秤评测过,请先评测", font: nil, color: deepBlue)
            }
        }
    }
    
    func setConnectDevice() {
        setSportDetail()
        setSleepDetail()
    }
    
    func setSportDetail() {
        sportDetailLabel.clear()
        if GoalManager.isSetGoal {
            if let showInfo = GoalManager.currentGoalInfo() {
                sportDetailLabel.append("过去7天内平均每天行走", font: nil, color: deepBlue)
                sportDetailLabel.append("\(showInfo.sevenDaysWalkAverageValue) 步\n", font: nil, color: lightBlue)
                sportDetailLabel.append("为按期达到目标\n建议每天行走", font: nil, color: deepBlue)
                sportDetailLabel.append("\(showInfo.dayWalkGoal) 步\n", font: nil, color: lightBlue)
            }
            else
            {
                sportDetailLabel.append("您还没有使用体重秤评测过,请先评测", font: nil, color: deepBlue)
            }
            
        }
    }
    
    func setSleepDetail() {
        sleepDetailLabel.clear()
        if GoalManager.isSetGoal {
            if let showInfo = GoalManager.currentGoalInfo() {
                sleepDetailLabel.append("过去7天内平均每天睡", font: nil, color: deepBlue)
                sleepDetailLabel.append("\(showInfo.sevenDaysSleepAverageValue)小时\n", font: nil, color: lightBlue)
                sleepDetailLabel.append("为按期达到目标\n建议每天睡眠", font: nil, color: deepBlue)
                sleepDetailLabel.append("8 小时\n", font: nil, color: lightBlue)
                sleepDetailLabel.append("深度睡眠应大于", font: nil, color: deepBlue)
                sleepDetailLabel.append("2 小时\n", font: nil, color: lightBlue)
            }
            else
            {
                sleepDetailLabel.append("您还没有使用体重秤评测过,请先评测", font: nil, color: deepBlue)
            }
        }
    }
    
    func setNoDeviceView() {
        noDeviceDetailLabel.clear()
        if let showInfo = GoalManager.currentGoalInfo() {
            noDeviceDetailLabel.append("为按期达到目标\n建议每天行走", font: nil, color: deepBlue)
            noDeviceDetailLabel.append("\(showInfo.sevenDaysWalkAverageValue) 步\n\n\n", font: nil, color: lightBlue)
            noDeviceDetailLabel.append("建议每天睡眠", font: nil, color: deepBlue)
            noDeviceDetailLabel.append("8 小时\n", font: nil, color: lightBlue)
            noDeviceDetailLabel.append("深度睡眠应大于", font: nil, color: deepBlue)
            noDeviceDetailLabel.append("2 小时\n", font: nil, color: lightBlue)
        }
        else
        {
            noDeviceDetailLabel.append("您还没有使用体重秤评测过,请先评测", font: nil, color: deepBlue)
        }
        
    }

    func showView(view: UIView) {
        noDeviceView.hidden = true
        connectDeviceView.hidden = true
        view.hidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Button Response
    @IBAction func setGoalPressed(sender: AnyObject) {
        let controller = GoalSettingViewController()
        AppDelegate.rootNavgationViewController().pushViewController(controller, animated: true)
    }

    @IBAction func showSportDetailPressed(sender: AnyObject) {
        AppDelegate.rootNavgationViewController().pushViewController(SportDetailViewController(), animated: true)
    }
    
    @IBAction func showSleepDetailPressed(sender: AnyObject) {
        AppDelegate.rootNavgationViewController().pushViewController(SleepDetailViewController(), animated: true)
    }
    
    @IBAction func buyDevicePressed(sender: AnyObject) {
        
    }
    
    @IBAction func bindDevicePressed(sender: AnyObject) {
        
        DeviceScanViewController.showDeviceScanViewController([DeviceType.Bracelet], delegate: self, rootController: AppDelegate.rootNavgationViewController())
    }
}

extension GoalViewController: DeviceScanViewControllerProtocol {
    func didSelected(controller: DeviceScanViewController, device: DeviceManagerProtocol) {
        
        // 绑定
        SettingManager.bindDevice(device)
        
        GoalManager.syncDatas ({ [unowned self] (error: NSError?) -> Void in
            if self.respondsToSelector(Selector("refreshView")) {
                self.refreshView()
            }
        })
    }
}
