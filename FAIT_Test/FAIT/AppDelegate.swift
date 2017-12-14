 //
//  AppDelegate.swift
//  FAIT
//
//  Created by Mar Nesbitt on 4/29/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
            // [Optional] Power your app with Local Datastore. For more info, go to
            // https://parse.com/docs/ios_guide#localdatastore/iOS
            Parse.enableLocalDatastore()
            
            // Initialize Parse.
            Parse.setApplicationId("eJDTCczpnCtWilEsX7zOk7E0RoUxPvWRAAj5lWVD",
                clientKey: "XsET6rMwx8PnZ2DDfPqMfhqbYgOdeiUTuv185hMg")
            
            // [Optional] Track statistics around application opens.
            PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        if(PFUser.currentUser() !== nil){
            println("User logged in")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let tabBarController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("homePageMainViewController") as! UIViewController
            
            let navigationController = self.window?.rootViewController as! UINavigationController
            navigationController.navigationBarHidden = true
            navigationController.setViewControllers([tabBarController], animated: true)
            
        }
        else{
           
            println("User not logged in")
            var pageController = UIPageControl.appearance()
            pageController.pageIndicatorTintColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 0.7)
            pageController.backgroundColor = UIColor.clearColor()
            pageController.currentPageIndicatorTintColor =  UIColor(red: (107.0/255.0), green: (185.0/255.0), blue: (198.0/255.0), alpha: 0.7)
            

            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let startUpController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! UIViewController
            
            let navigationController = self.window?.rootViewController as! UINavigationController
            navigationController.navigationBarHidden = true
            navigationController.setViewControllers([startUpController], animated: true)
        }
            
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
}

