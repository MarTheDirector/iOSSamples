//
//  sparkViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt & ZaC Gordon on 4/29/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import Foundation
import UIKit

class mainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = true 
        // Do any additional setup after loading the view, typically from a nib.
        
        //set up variables that regonize that we want to use the UISwipeGesutre library to handle a swipe direction make sure handlers have : because they are linked up to sender in our function
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        
        
        //sets this swip gesture to an actual direction in this case left in right
        
        leftSwipe.direction = .Left
        
        rightSwipe.direction = .Right
        
        
        
        
        
        //sets up our view to recognize these swipe gestures
        
        view.addGestureRecognizer(leftSwipe)
        
        view.addGestureRecognizer(rightSwipe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        return false
    }
    
   /* func handleSwipes(sender:UISwipeGestureRecognizer){
        
        //since sender is now linked to view we will create an if statement on sender to see which direction swiped
        
        if(sender.direction == .Left){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("sparkViewController") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
        }//end of if statement
        
        if(sender.direction == .Right){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("chanceViewController") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
        }//end of if statement
        
        
        
    }//end of func handleswips*/
    
    
}
