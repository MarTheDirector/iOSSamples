//
//  MySwipe.swift
//  EZSwipeController
//
//  Created by Goktug Yilmaz on 14/11/15.
//  Copyright © 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit
// import EZSwipeController // if using Cocoapods
class MySwipeVC: EZSwipeController {
    override func setupView() {
        datasource = self
//        navigationBarShouldBeOnBottom = true
//        navigationBarShouldNotExist = true
//        cancelStandardButtonEvents = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
    }
}

extension MySwipeVC: EZSwipeControllerDataSource {
    
    func viewControllerData() -> [UIViewController] {
       
        
        
        
        //MARK: Load view controllers from storyboard here
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewControllerWithIdentifier("mainView") as! MainViewController
        let settings = storyboard.instantiateViewControllerWithIdentifier("settingsView") as! SettingsViewController
        let inbox = storyboard.instantiateViewControllerWithIdentifier("inboxView") as! InboxViewController
        return [settings, main, inbox]
    }
    
    func navigationBarDataForPageIndex(index: Int) -> UINavigationBar {
        
        var iconMainImage = UIImage(named: "mainIcon")!
        iconMainImage = scaleTo(image: iconMainImage, w: 22, h: 22)
        let iconMainItem = UIBarButtonItem(image: iconMainImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
        iconMainItem.tintColor = UIColor(red: 97/255, green: 140/255, blue: 170/255, alpha: 1)
        
        var gearImage = UIImage(named: "gear")!
        gearImage = scaleTo(image: gearImage, w: 22, h: 22)
        let gearItem = UIBarButtonItem(image: gearImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
        iconMainItem.tintColor = UIColor(red: 97/255, green: 140/255, blue: 170/255, alpha: 1)
        
        var inboxImage = UIImage(named: "message")!
        inboxImage = scaleTo(image: inboxImage, w: 22, h: 22)
        let inboxItem = UIBarButtonItem(image: inboxImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
        inboxItem.tintColor = UIColor(red: 97/255, green: 140/255, blue: 170/255, alpha: 1)
        
        
        
        
        var title = ""
        if index == 0 {
            //title = iconMainItem
            title = "Settings"
        } else if index == 1 {
            //title = gearItem
            title = "Impression"
        } else if index == 2 {
            //title = inboxItem
            title = "Inbox"
        }
        
        let navigationBar = UINavigationBar()
        navigationBar.barStyle = UIBarStyle.Default
        navigationBar.barTintColor = UIColor(red: 163/255, green: 190/255, blue: 201/255, alpha: 1)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 242/255, green: 246/255, blue: 247/255, alpha: 1)]
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.hidesBackButton = true
        
        switch(index){
        case  0:
            var sImage = UIImage(named: "sideIcon")!
            sImage = scaleTo(image: sImage, w: 30, h: 30)
            let rightButtonItem = UIBarButtonItem(image: sImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
            rightButtonItem.tintColor = UIColor(red: 242/255, green: 246/255, blue: 247/255, alpha: 1)
            
            //Mark for navigation Title here
            var gearIcon = UIImage(named: "gearBlue")!
            var titleView : UIImageView
            // set the dimensions you want here
            titleView = UIImageView(frame:CGRectMake(0, 0, 40, 40))
            
            // Set how do you want to maintain the aspect
            titleView.contentMode = .ScaleAspectFit
            //titleView.image = UIImage(named: "gear")
            titleView.image = gearIcon
            
            navigationItem.titleView = titleView
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = rightButtonItem
            break
        case 1:
            var cImage = UIImage(named: "gear")!
            cImage = scaleTo(image: cImage, w: 30, h: 30)
            let leftButtonItem = UIBarButtonItem(image: cImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
            leftButtonItem.tintColor = UIColor(red: 242/255, green: 246/255, blue: 247/255, alpha: 1)
            
            var bImage = UIImage(named: "message")!
            bImage = scaleTo(image: bImage, w: 30, h: 30)
            let rightButtonItem = UIBarButtonItem(image: bImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
            rightButtonItem.tintColor = UIColor(red: 242/255, green: 246/255, blue: 247/255, alpha: 1)
            
            //Mark for navigation Title here
            var mainIcon = UIImage(named: "mainIcon")!
            var titleView : UIImageView
            // set the dimensions you want here
            titleView = UIImageView(frame:CGRectMake(0, 0, 40, 40))
            
            // Set how do you want to maintain the aspect
            titleView.contentMode = .ScaleAspectFit
            //titleView.image = UIImage(named: "gear")
            titleView.image = mainIcon
            
            navigationItem.titleView = titleView

            
            navigationItem.leftBarButtonItem = leftButtonItem
            navigationItem.rightBarButtonItem = rightButtonItem
            break; /* optional */
        case 2:
            var sImage = UIImage(named: "sideIcon")!
            sImage = scaleTo(image: sImage, w: 30, h: 30)
            let leftButtonItem = UIBarButtonItem(image: sImage, style: UIBarButtonItemStyle.Plain, target: self, action: "a")
            leftButtonItem.tintColor = UIColor(red: 242/255, green: 246/255, blue: 247/255, alpha: 1)
            
            
            //Mark for navigation Title here
            var messageIcon = UIImage(named: "messageBlue")!
            var titleView : UIImageView
            // set the dimensions you want here
            titleView = UIImageView(frame:CGRectMake(0, 0, 40, 40))
            
            // Set how do you want to maintain the aspect
            titleView.contentMode = .ScaleAspectFit
            //titleView.image = UIImage(named: "gear")
            titleView.image = messageIcon
            
            navigationItem.titleView = titleView
            
            navigationItem.leftBarButtonItem = leftButtonItem
            navigationItem.rightBarButtonItem = nil
            break; /* optional */
            /* you can have any number of case statements */
        default : /* Optional */
            print("hi");
        }
        
        navigationBar.pushNavigationItem(navigationItem, animated: false)
        return navigationBar

    }
    
    func alert(title title: String?, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func indexOfStartingPage() -> Int {
        return 1 // EZSwipeController starts from 2nd, green page
    }
}

private func scaleTo(image image: UIImage, w: CGFloat, h: CGFloat) -> UIImage {
    let newSize = CGSize(width: w, height: h)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}


private extension UIImageView {
    
    /// EZSwiftExtensions
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, imageName: String) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        image = UIImage(named: imageName)
    }
    
    /// EZSwiftExtensions
    convenience init(x: CGFloat, y: CGFloat, imageName: String, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        image = UIImage(named: imageName)
        scaleImageFrameToWidth(width: scaleToWidth)
    }
    
    /// EZSwiftExtensions
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, image: UIImage) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.image = image
    }
    
    /// EZSwiftExtensions
    convenience init(x: CGFloat, y: CGFloat, image: UIImage, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        self.image = image
        scaleImageFrameToWidth(width: scaleToWidth)
    }
    
    /// EZSwiftExtensions, scales this ImageView size to fit the given width
    func scaleImageFrameToWidth(width width: CGFloat) {
        let widthRatio = image!.size.width / width
        let newWidth = image!.size.width / widthRatio
        let newHeigth = image!.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
    }
    
}
