//
//  MaxLengthRule.swift
//  Validator
//
//  Created by Guilherme Berger on 4/6/15.
//

import Foundation
import UIKit

public class MaxLengthRule: Rule {
    
    private var DEFAULT_LENGTH: Int = 20
    
    public init(){}
    
    public init(length: Int){
        self.DEFAULT_LENGTH = length
    }
    
    public func validate(value: String) -> Bool {
        return count(value) <= DEFAULT_LENGTH
    }
    
    public func errorMessage() -> String {
        return "Must be shorter than \(DEFAULT_LENGTH) characters"
    }
    
    public func errorIcon() -> UIImage {
        
        return UIImage(named: "atRed.png")!
    }
    
}
