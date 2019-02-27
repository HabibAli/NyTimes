//
//  UILabel+Utils.swift
//  Nytimes
//
//  Created by Habib Ali on 10/08/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

extension UILabel{
    
    func addRightImage(image:UIImage, attributedString: NSAttributedString) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 25, y: 0, width: 10, height: 15)
        let attachmentString = NSAttributedString(attachment: attachment)
        
        let myString = NSMutableAttributedString(string: "")
        myString.append(attributedString)
        myString.append(attachmentString)
        self.attributedText = myString
    }
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
