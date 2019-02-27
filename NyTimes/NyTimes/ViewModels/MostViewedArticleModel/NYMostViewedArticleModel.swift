//
//  NYLoginViewModel.swift
//  Nytimes
//
//  Created by Habib Ali on 26/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

protocol NYMostViewedArticleModelDelegate : NYViewModelDelegate{
    func numberOfSections()->Int
    func numberOfRowsInSection(section:Int)->Int
    func dataForIndexPath(indexPath:IndexPath)->Any
}

class NYMostViewedArticleModel: NYBaseViewModel {

    weak var del : NYMostViewedArticleModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        del = delegate as?  NYMostViewedArticleModelDelegate
    }
    
    
}
