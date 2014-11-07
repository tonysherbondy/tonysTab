//
//  TabBarViewController.swift
//  tonysTab
//
//  Created by Anthony Sherbondy on 11/4/14.
//  Copyright (c) 2014 iosfd. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var firstViewController: UIViewController!
    var secondViewController: UIViewController!
    var thirdViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        firstViewController = storyboard.instantiateViewControllerWithIdentifier("FirstViewController") as UIViewController
        self.addChildViewController(firstViewController)
        
        secondViewController = storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as UIViewController
        self.addChildViewController(secondViewController)
        
        thirdViewController = storyboard.instantiateViewControllerWithIdentifier("ThirdViewController") as UIViewController
        self.addChildViewController(thirdViewController)
        
        scrollView.contentSize = CGSize(width: 320*3, height: scrollView.frame.height)
        firstViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.frame.size)
        secondViewController.view.frame = CGRect(origin: CGPoint(x: 320, y: 0), size: scrollView.frame.size)
        thirdViewController.view.frame = CGRect(origin: CGPoint(x: 640, y: 0), size: scrollView.frame.size)
        
        scrollView.addSubview(firstViewController.view)
        scrollView.addSubview(secondViewController.view)
        scrollView.addSubview(thirdViewController.view)
        
        firstViewController.didMoveToParentViewController(self)
        secondViewController.didMoveToParentViewController(self)
        thirdViewController.didMoveToParentViewController(self)
        
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("did scroll \(scrollView.contentOffset.x)")
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            var scrollOffset = scrollView.contentOffset.x
            self.indicatorView.frame.origin.x = self.convertValue(scrollOffset, r1Min: 0, r1Max: 320*2, r2Min: 30, r2Max: 280)
        })
        
    }


    @IBAction func onFirstButton(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.contentOffset.x = 0
            
            }) { (finished: Bool) -> Void in
                
            self.scrollViewDidEndDecelerating(self.scrollView)
        }
    }
    
    @IBAction func onSecondButton(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset.x = 320
        })
    }
    
    @IBAction func onThirdButton(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset.x = 640
        })
    }
    
    func convertValue(value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
}
