//
//  NYBaseCell.swift
//  NyTimes
//
//  Created by Habib Ali on 27/02/2019.
//  Copyright © 2019 Folio3. All rights reserved.
//

import Foundation
import UIKit


struct NYBaseCellConstant {
    
    static let Identifier = "Identifier"
}

class NYBaseCell : UITableViewCell{
    
    func configure(data: Any , indexPath: IndexPath){
        
    }
    
    @objc class var identifier: String {
        return String(describing: self)
    }
    
}
