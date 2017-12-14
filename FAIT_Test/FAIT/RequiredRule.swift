//
//  Required.swift
//  pyur-ios
//
//  Created by Jeff Potter on 12/22/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public class RequiredRule: Rule {
    
    public init(){}
    
    var message: String {
        return "Please input info here"
    }
    
    public func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    
    public func errorMessage() -> String {
        return message
    }
    
    public func errorIcon() -> UIImage {
        
        return UIImage(named: "atRed.png")!
    }
    
    
}