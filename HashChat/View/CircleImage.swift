//
//  CircleImage.swift
//  HashChat
//
//  Created by Andrii Kost on 2/20/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    // doing full rounding of the image view based on width
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        // perfect circle
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    // doing full rounding of the image view based on width
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
