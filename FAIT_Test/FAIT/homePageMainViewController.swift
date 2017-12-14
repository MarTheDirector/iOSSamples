//
//  homePageMainViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/23/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//


import UIKit
import CoreLocation
import Parse

class homePageMainViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        
        //self.dismissViewControllerAnimated(true, completion: {})
       // self.parentViewController dismissViewControllerAnimated:YES completion: nil
    }
   
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil
            {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0
            {
                
                let pm = placemarks [0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            
            
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark)
    {
            self.locationManager.stopUpdatingLocation()
            
        
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        
        //find a way to re request address if phone data is off then
        println("Error: " + error.localizedDescription)
        println("Error: " +  error.localizedFailureReason!)
    }
    
    //built in method
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //we call end editing which states that we are done editing with any object that was marked as firstresponder
        self.view.endEditing(true)
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}