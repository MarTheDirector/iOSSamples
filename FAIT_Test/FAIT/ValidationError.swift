//
//  File.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public class ValidationError {
    public let textField:UITextField
    public var errorLabel:UILabel?
    public let errorMessage:String
    public var image:UIImageView
    public var viewConstraint: NSLayoutConstraint?
    public var lineConstraint: NSLayoutConstraint?
    public var errorConstraint: NSLayoutConstraint?
    public var line: UIView?
    public var errorIcon: UIImage
    public var validIcon: UIImage?
    
    
    public init(textField:UITextField, error:String, image: UIImageView, viewConstraint: NSLayoutConstraint?, lineConstraint: NSLayoutConstraint, errorConstraint: NSLayoutConstraint, line: UIView, errorIcon: UIImage, validIcon: UIImage){
        self.textField = textField
        self.errorMessage = error
        self.image = image
        self.viewConstraint = viewConstraint
        self.lineConstraint = lineConstraint
        self.errorConstraint = errorConstraint
        self.line = line
        self.errorIcon = errorIcon
        self.validIcon = validIcon
        
    }
    
    public init(textField:UITextField, errorLabel:UILabel?, error:String, image:UIImageView, viewConstraint: NSLayoutConstraint?, lineConstraint: NSLayoutConstraint, errorConstraint: NSLayoutConstraint, line: UIView, errorIcon: UIImage, validIcon: UIImage){
        self.textField = textField
        self.errorLabel = errorLabel
        self.errorMessage = error
        self.image = image
        self.viewConstraint = viewConstraint
        self.lineConstraint = lineConstraint
        self.errorConstraint = errorConstraint
        self.line = line
        self.errorIcon = errorIcon
        self.validIcon = validIcon
    }
}