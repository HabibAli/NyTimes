//
//  NYMostViewedArticleViewController.swift
//  Nytimes
//
//  Created by Habib Ali on 25/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

class NYMostViewedArticleViewController: NYBaseViewController,NYMostViewedArticleModelDelegate{
    
    var vModel : NYMostViewedArticleModel?
    
    override func viewDidLoad() {
        viewModel = NYMostViewedArticleModel(del:self)
        vModel = viewModel as? NYMostViewedArticleModel
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
}
