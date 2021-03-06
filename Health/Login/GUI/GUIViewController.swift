//
//  GUIViewController.swift
//  Health
//
//  Created by Yalin on 15/8/20.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

class GUIViewController: UIViewController {
    
    var imageViews:[UIImageView] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    convenience init() {
        self.init(nibName: "GUIViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageViews.append(UIImageView(image: UIImage(named: "GUI001")))
        imageViews.append(UIImageView(image: UIImage(named: "GUI002")))
        imageViews.append(UIImageView(image: UIImage(named: "GUI003")))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for var i = 0; i < imageViews.count; i++ {
            let imageView = imageViews[i]
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.frame = CGRect(x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(imageViews.count), height: 0)
        
        self.view.layoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func frontButtonPressed(sender: AnyObject) {
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x - scrollView.bounds.size.width, 0), animated: true)
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        if pageControl.currentPage == imageViews.count - 1 {
            skipButtonPressed(sender)
            
        }
        else {
            scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x + scrollView.bounds.size.width, 0), animated: true)
        }
    }

    @IBAction func skipButtonPressed(sender: AnyObject) {
        if !LoginManager.isLogin || LoginManager.isNeedCompleteInfo{
            AppDelegate.applicationDelegate().changeToLoginController()
        }
        else {
            AppDelegate.applicationDelegate().changeToMainController()
        }
        
        LoginManager.showedGUI = true
    }
    
}

extension GUIViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width / 2
        let page = Int(offsetX / scrollView.bounds.size.width)
        self.pageControl.currentPage = page
        
        frontButton.hidden = false
        nextButton.hidden = false
        nextButton.setTitle("下一页", forState: UIControlState.Normal)
        if page == pageControl.numberOfPages - 1 {
            nextButton.setTitle("开始使用", forState: UIControlState.Normal)
        }
        else if page == 0 {
            frontButton.hidden = true
        }
    }
}
