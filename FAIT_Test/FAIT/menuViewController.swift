//
//  menuViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt on 7/19/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var postJot: UIButton!
    @IBOutlet weak var postPicture: UIButton!
    @IBOutlet weak var postVideo: UIButton!
    
    // create instance of our custom transition manager
    let transitionManager = MenuTransitionManager()
    
    // create references to the items on the storyboard
    // so that we can animate their properties
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.transitioningDelegate = self.transitionManager
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

