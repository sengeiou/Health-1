//
//  UserSelectView.swift
//  Health
//
//  Created by Yalin on 15/8/20.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

class UserSelectView: UIView {
    
    
    private let headImageViewTag = 1001
    private let nameLabelTag = 1002
    private var userViews: [UIView] = []
    private var scrollView: UIScrollView = UIScrollView()
    private var showHeadView: UIView
    
    var users:[(String, String, String)] = [] // 数据格式 (userId, headURLStr, name)
    
    
    // MARK: - 初始化
    required init(coder aDecoder: NSCoder) {
        
        showHeadView = NSBundle.mainBundle().loadNibNamed("UserView", owner: nil, options: nil)[0] as! UIView
        
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        
        showHeadView.frame = self.bounds
        self.addSubview(showHeadView)
        
        let (headButton, nameLabel, changeButton) = getShowViewControl()
        headButton.addTarget(self, action: Selector("changePeoplePressed"), forControlEvents: UIControlEvents.TouchUpInside)
        changeButton.addTarget(self, action: Selector("changePeoplePressed"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        scrollView.frame = self.bounds
        // add user
        setUsers([("\(UserData.shareInstance().userId)", "", UserData.shareInstance().name!)])
    }

    // MARK: - 选择视图
    // 数据格式 (userId, headURLStr, name)
    func setUsers(users: [(String, String, String)]) {
        self.users = users
        self.users += [("", "", "新增")]
        for view in userViews {
            view.removeFromSuperview()
        }
        userViews.removeAll(keepCapacity: false)
        
        var startCenter = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        let padding: CGFloat = 112
        for var i = 0; i < self.users.count; i++ {
            let (userId, headURLStr, name) = self.users[i]
            var view = createSelectedHeadView((headURLStr, name, i))
            view.center = startCenter
            scrollView.addSubview(view)
            startCenter = CGPoint(x: startCenter.x + padding, y: startCenter.y)
            
            if i == 0 {
                setShowView((headURLStr, name))
            }
        }
        
        scrollView.contentSize = CGSize(width: startCenter.x + 48 - 112, height: 0)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func setShowView(info: (String, String)) {
        // 设置showView
        let (headURLStr, name) = info
        let (headButton, nameLabel, _) = getShowViewControl()
        
        headButton.sd_setImageWithURL(NSURL(string: headURLStr), forState: UIControlState.Normal, placeholderImage: UIImage(named: "defaultHead"))
        nameLabel.text = name
    }
    
    func createSelectedHeadView(info: (String, String, Int)) -> UIView {
        var headView = UIView(frame: CGRectMake(0, 0, 80, self.frame.size.height))
        
        let (headURLStr, name, tag) = info
        
        // 头像
        var headImageView = UIImageView(frame: CGRectMake(15, 8, 50, 50))
        headImageView.sd_setImageWithURL(NSURL(string: headURLStr), placeholderImage: UIImage(named: "defaultHead"))
        headView.addSubview(headImageView)
        headImageView.tag = headImageViewTag
        
        // 名字
        var nameLabel = UILabel(frame: CGRectMake(0, 66, 81, 21))
        nameLabel.text = name
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.tag = nameLabelTag
        headView.addSubview(nameLabel)
        
        // 点击button
        var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.frame = headView.bounds
        button.addTarget(self, action: Selector("selectHeadViewClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.tag = tag
        headView.addSubview(button)
        
        return headView
    }
    
    func selectHeadViewClick(button: UIButton) {
        self.scrollView.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)
        self.showHeadView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
    }
    
    // MARK: - ShowView Method
    func changePeoplePressed() {
        self.showHeadView.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)
        self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func getShowViewControl() -> (UIButton, UILabel, UIButton) {
        var headButton = showHeadView.viewWithTag(headImageViewTag) as! UIButton
        var nameLabel = showHeadView.viewWithTag(nameLabelTag) as! UILabel
        var changeButton = showHeadView.viewWithTag(1003) as! UIButton
        
        return (headButton, nameLabel, changeButton)
    }
}

class UserView: UIView {
    
}