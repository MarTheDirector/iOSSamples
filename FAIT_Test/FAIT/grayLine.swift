//
//  grayLine.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/14/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit

class grayLine: UIView {

    
    override func drawRect(rect: CGRect) {
        // Context of what the object we're going to use for drawing is
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 3)
        CGContextSetStrokeColorWithColor(context,  UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0).CGColor)
        //Give a path to draw in
        CGContextMoveToPoint(context, 0, 0)
        
        //makes line from where ever it is at that time to new point
        CGContextAddLineToPoint(context, 300, 0)
        
        
        //actually follows path drawing out what you layed out
        CGContextStrokePath(context)
        
    }
   

}
