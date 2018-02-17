//
//  GradientView.swift
//  HashChat
//
//  Created by Andrii Kost on 2/17/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    // Update inside the storyboard dynamicly
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            //Update layout when it's changed
            self.setNeedsLayout()
        }
    }
    
    // Update inside the storyboard dynamicly
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            //Update layout when it's changed
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        
        // create a layer
        let gradientLayer = CAGradientLayer()
        
        //colors participainting in gradient, there's no limit for the colors
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        // start and end point
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        
        // end of the screen
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        // what size view is going to be
        gradientLayer.frame = self.bounds
        
        // add gradient layer to the uiview layer
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }

}
