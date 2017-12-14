//
//  customSegueUnwind.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/14/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit

class customSegueUnwind: UIStoryboardSegue {
    
    override func perform() {
        // Assign the source and destination views to local variables.
        var secondVCView = self.sourceViewController.view as UIView!
        var firstVCView = self.destinationViewController.view as UIView!
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: secondVCView)
        
        
        
        // Animate the transition.
       /* UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, screenHeight)
            
            }) { (Finished) -> Void in
                
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }*/
        
        
         func segueForUnwindingToViewController(toViewController: UIViewController,
            fromViewController: UIViewController,
            identifier: String?) -> UIStoryboardSegue {
                return UIStoryboardSegue(identifier: identifier, source: fromViewController, destination: toViewController) {
                    let fromView = fromViewController.view
                    let toView = toViewController.view
                    if let containerView = fromView.superview {
                        let initialFrame = fromView.frame
                        var offscreenRect = initialFrame
                        offscreenRect.origin.x -= CGRectGetWidth(initialFrame)
                        toView.frame = offscreenRect
                        containerView.addSubview(toView)
                        // Being explicit with the types NSTimeInterval and CGFloat are important
                        // otherwise the swift compiler will complain
                        let duration: NSTimeInterval = 1.0
                        let delay: NSTimeInterval = 0.0
                        let options = UIViewAnimationOptions.CurveEaseInOut
                        let damping: CGFloat = 0.5
                        let velocity: CGFloat = 4.0
                        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: damping,
                            initialSpringVelocity: velocity, options: options, animations: {
                                toView.frame = initialFrame
                            }, completion: { finished in
                                toView.removeFromSuperview()
                                if let navController = toViewController.navigationController {
                                    navController.popToViewController(toViewController, animated: false)
                                }
                        })
                    }
                }
        }
    }
    
}

