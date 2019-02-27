//
//  NYArticleCell.swift
//  NyTimes
//
//  Created by Habib Ali on 27/02/2019.
//  Copyright © 2019 Folio3. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


struct NYArticleCellConstant {
    static let ArticleImageUrl = "ArticleImageUrl"
    static let ArticleTitle = "ArticleTitle"
    static let ArticleDesc = "ArticleDesc"
}

class NYArticleCell : NYBaseCell{
    
    
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    override func configure(data: Any, indexPath: IndexPath) {
        if let keyValue = data as? [String:Any]{
            
            imgVw.sd_setImage(with: URL(string: keyValue[NYArticleCellConstant.ArticleImageUrl] as! String), placeholderImage: UIImage(named: "BlackCircle.png"))
            lblTitle.text = keyValue[NYArticleCellConstant.ArticleTitle] as? String
            lblDesc.text = keyValue[NYArticleCellConstant.ArticleDesc] as? String
        }
    }
    
}
