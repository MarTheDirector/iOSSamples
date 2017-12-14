//
//  ValidationRule.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public class ValidationRule {
    public var textField:UITextField
    public var errorLabel:UILabel?
    public var rules:[Rule] = []
    public var image: UIImageView?
    public var viewConstraint: NSLayoutConstraint?
    public var lineConstraint: NSLayoutConstraint?
    public var errorConstraint: NSLayoutConstraint?
    public var line: UIView?
    public var validIcon: UIImage?
    
    public init(textField: UITextField, rules:[Rule], errorLabel:UILabel?, image: UIImageView?, viewConstraint: NSLayoutConstraint?, lineConstraint: NSLayoutConstraint?, errorConstraint: NSLayoutConstraint?, line: UIView?, validIcon: UIImage?){
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
        self.image = image
        self.viewConstraint = viewConstraint
        self.lineConstraint = lineConstraint
        self.errorConstraint = errorConstraint
        self.line = line
        self.validIcon = validIcon
            }
    
    public func validateField() -> ValidationError? {
        for rule in rules {
            if !rule.validate(textField.text) {
                return ValidationError(textField: self.textField, errorLabel:self.errorLabel, error: rule.errorMessage(), image: self.image!, viewConstraint: self.viewConstraint!, lineConstraint: self.lineConstraint!, errorConstraint: self.errorConstraint!, line: self.line!, errorIcon: rule.errorIcon(), validIcon: self.validIcon!)
            }
        }
        return nil
    }
}