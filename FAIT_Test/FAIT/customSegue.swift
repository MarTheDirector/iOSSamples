//
//  customSegue.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/14/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit

class customSegue: UIStoryboardSegue {
    override func perform() {
        // Assign the source and destination views to local variables.
        var firstVCView = self.sourceViewController.view as UIView!
        var secondVCView = self.destinationViewController.view as UIView!
        
        // Get the screen width and height.
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        
        // Animate the transition.
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, -screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, -screenHeight)
            
            }) { (Finished) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController as! UIViewController,
                    animated: false,
                    completion: nil)
        }
    }
    
    /*override func perform() {
        
        var sourceViewController:UIViewController = self.sourceViewController as! UIViewController
        var destinationViewController:UIViewController = self.destinationViewController as! UIViewController
        
        sourceViewController.view.addSubview(destinationViewController.view)
        
        destinationViewController.view.transform = CGAffineTransformMakeScale(0.05,0.05)
        
        UIView.animateWithDuration(0.5,delay:0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations:{ () -> Void in
            
            
                destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            }) {(finished) -> Void in
                
                destinationViewController.view.removeFromSuperview()
                sourceViewController.presentViewController(destinationViewController, animated:false, completion:nil)
                
                
            }
    }*/
    
}
