//
//  RoundButton.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
import QuartzCore
// made my button round
@IBDesignable public class MyButton: UIButton
    {
    override public func layoutSubviews() {
            super.layoutSubviews()
            
            updateCornerRadius()
        }
        
        @IBInspectable var rounded: Bool = false {
            didSet {
                updateCornerRadius()
            }
        }
        
        func updateCornerRadius() {
            layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        }
   
}

extension CALayer {
    func roundCorners(corners: UIRectCorner, radius: CGFloat, bounds: CGRect) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius)).cgPath
        let shape = CAShapeLayer()
        shape.path = maskPath
        mask = shape
    }

}
