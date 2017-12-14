//
//  test.swift
//  Koloda
//
//  Created by Mar Nesbitt on 2/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit



@IBDesignable class TNNib: UIView {
    
     var view:UIView!;
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    func loadViewFromNib() {
        //pageControl.translatesAutoresizingMaskIntoConstraints = false
        //pageControl.transform = CGAffineTransformMakeRotation(CGFloat(Float(M_PI_2)))
        //view.frame = bounds
        //view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //self.addSubview(view);
    }
    
    
    
}