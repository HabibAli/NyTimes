//
//  Float+Utils.swift
//  Nytimes
//
//  Created by Habib Ali on 06/08/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

extension Float {
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
