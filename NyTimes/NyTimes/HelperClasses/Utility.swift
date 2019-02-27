//
//  Utility.swift
//  Nytimes
//
//  Created by Habib Ali on 09/07/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    static var changeToGoalType : Int?
    
    static func attributedText(withString string: String, boldString: String, normalFont: UIFont, boldFont: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: normalFont])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: boldFont]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    static func setupAppAppearence() {
        UIApplication.shared.statusBarStyle = .lightContent
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        let image = UIImage(named: "navigation-bar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        UINavigationBar.appearance().setBackgroundImage(image, for: .default)
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.font: Constants.Fonts.SFUITextDisplayBlackFontWithSize(size:18)]
        UIButton.appearance().isExclusiveTouch = true
    }
    
    static func getFormattedStringForDate(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
