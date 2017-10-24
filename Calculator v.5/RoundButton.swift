//
//  RoundButton.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit


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

extension UIButton {
    func pulseButton(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 7, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 7, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        layer.add(animation, forKey: nil)
}
}
