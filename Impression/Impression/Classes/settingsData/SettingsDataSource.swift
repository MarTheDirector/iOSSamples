//
//  SettingsDataSource.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit

class SettingDataSource
{
    // Variables
    var name: String            // name of the product line
    var cell: [SettingCell]     // all products in the line
    
    init(named: String, includeSetting: [SettingCell])
    {
        name = named
        cell = includeSetting
    }
    
    class func settingsLines() -> [SettingDataSource]
    {
        return [self.getInfo()]
    }
    
    // Private methods
    
    private class func getInfo() -> SettingDataSource {
        //  (1) iDevices: Apple Watch, iPad, iPhone, iOS
        var settings = [SettingCell]()
        
        settings.append(SettingCell(titled: "Discovery Settings", description: "Distance, age and more", imageName: "pug.jpg"))
        
        settings.append(SettingCell(titled: "App Settings", description: "Notifications, account and more", imageName: "pug2.jpg"))
        
        settings.append(SettingCell(titled: "Help & Support", description: "FAQ, contact, and more", imageName: "pug3.jpg"))
        
        
        settings.append(SettingCell(titled: "Give Us Feedback", description: "Help us make your experience better", imageName: "pug4.jpg"))
        
        settings.append(SettingCell(titled: "Make A Pro Impression ", description: "Change Your Location", imageName: "pug2.jpg"))
        
        return SettingDataSource(named: "settingsCell", includeSetting: settings)
    }
    
}