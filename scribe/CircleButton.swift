//
//  CircleButton.swift
//  scribe
//
//  Created by Cody Condon on 2016-09-23.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
@IBDesignable
class CircleButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
           setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
