//
//  InboxViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {
    
    @IBOutlet weak var imageSlide: TNImageSliderViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image1 = UIImage(named: "pug")
        let image2 = UIImage(named: "pug2")
        let image3 = UIImage(named: "pug3")
        
        if let image1 = image1, let image2 = image2, let image3 = image3 {
            
            // 1. Set the image array with UIImage objects
            imageSlide.images = [image1, image2, image3]
            
            // 2. If you want, you can set some options
            var options = TNImageSliderViewOptions()
            options.pageControlHidden = false
            options.scrollDirection = .Vertical
            options.pageControlCurrentIndicatorTintColor = UIColor(red: 97/255, green: 140/255, blue: 170/255, alpha: 1)
            
            options.autoSlideIntervalInSeconds = 0
            options.shouldStartFromBeginning = true
            
            imageSlide.options = options
            
        }else {
            
            print("[ViewController] Could not find one of the images in the image catalog")
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //for the test
    }
    
    
}
