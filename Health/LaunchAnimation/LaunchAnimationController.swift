//
//  LaunchAnimationController.swift
//  Health
//
//  Created by Yalin on 15/11/3.
//  Copyright © 2015年 Yalin. All rights reserved.
//

import UIKit

class LaunchAnimationController: UIViewController {

    @IBOutlet weak var imageView: FLAnimatedImageView!
    private var complete: (() -> Void)?
    
    static func showLaunchAnimationController(complete: () -> Void) -> LaunchAnimationController {
        let controller = LaunchAnimationController()
        controller.complete = complete;
        return controller;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSBundle.mainBundle().URLForResource("launchAnimation", withExtension: "gif")
        let data = NSData(contentsOfURL: url!)
        
        let animatedImage = FLAnimatedImage(animatedGIFData: data)
        imageView.animatedImage = animatedImage
        
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("animationFinished"), userInfo: nil, repeats: false)
    }
    
    convenience init() {
        self.init(nibName: "LaunchAnimationController", bundle: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animationFinished() {
        complete?()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
