//
//  ViewController.swift
//  mapinte
//
//  Created by Mar on 10/15/17.
//  Copyright © 2017 DreamDrawn. All rights reserved.
//

import UIKit
import Localize_Swift


class ViewController: UIViewController {
    var languages = Localize.availableLanguages()
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let preferredLanguage = NSLocale.preferredLanguages[0]
        Localize.setCurrentLanguage(preferredLanguage)
        print(preferredLanguage)
    }
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    // MARK: Localized Text
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        signUpButton.layer.shadowRadius = 8
        signUpButton.layer.shadowOpacity = 0.3
        signUpButton.setTitle("sign Up".localized(using: "ButtonTitles"), for: UIControlState.normal)
        signInButton.setTitle("Sign In".localized(using: "ButtonTitles"), for: UIControlState.normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

