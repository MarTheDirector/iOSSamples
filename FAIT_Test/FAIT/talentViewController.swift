//
//  talentViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt & Zac Gordon on 4/29/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import Foundation
import UIKit

class talentViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageDescription: UILabel!
 
    
    var pageIndex: Int!
    var titleText: NSAttributedString!
    var imageFile: String!
    var pageText: String!
    var dotColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set up variables that regonize that we want to use the UISwipeGesutre library to handle a swipe direction make sure handlers have : because they are linked up to sender in our function
        
        self.imageView.image = UIImage(named: self.imageFile)
        
         self.titleLabel.attributedText = self.titleText
        self.pageDescription.text = self.pageText
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
