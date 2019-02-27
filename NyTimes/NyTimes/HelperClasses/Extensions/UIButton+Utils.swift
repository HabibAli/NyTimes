//
//  UIButton+Utils.swift
//  Nytimes
//
//  Created by Habib Ali on 21/08/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

extension UIButton{
    
    func autoShrinkTo(scale:CGFloat){
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = scale
    }
}
