//
//  CircleButton.swift
//  Scribe
//
//  Created by Anshu Vij on 02/06/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 30.0 {
        didSet {
            setUPview()
        
    }
    }
    override func prepareForInterfaceBuilder() {
        setUPview()
    }
    func setUPview ()
    {
        layer.cornerRadius = cornerRadius
        
    }

}
