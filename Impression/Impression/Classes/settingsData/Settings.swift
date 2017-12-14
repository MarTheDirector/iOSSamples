//
//  settings.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit

class SettingCell
{
    var title: String
    var description: String
    var image: UIImage
   
    
    init(titled: String, description: String, imageName: String)
    {
        self.title = titled
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "default")!
        }
    }
}



