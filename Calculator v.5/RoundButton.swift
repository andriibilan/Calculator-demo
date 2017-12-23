//
//  RoundButton.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

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
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
        func updateCornerRadius() {
            layer.cornerRadius = cornerRadius
        }
    // MARK: - Shadow
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
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
