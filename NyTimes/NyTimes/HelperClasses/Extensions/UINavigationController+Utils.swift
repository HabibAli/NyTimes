//
//  UINavigationController+Utils.swift
//  Nytimes
//
//  Created by Habib Ali on 26/07/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

extension UINavigationController {
    func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
}
