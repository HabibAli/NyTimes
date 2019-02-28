//
//  NYLoginViewModel.swift
//  Nytimes
//
//  Created by Habib Ali on 26/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

protocol NYMostViewedArticleModelDelegate : NYViewModelDelegate{
    
}

class NYMostViewedArticleModel: NYBaseViewModel {

    weak var del : NYMostViewedArticleModelDelegate?
    var articles : [NYArticle]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        del = delegate as?  NYMostViewedArticleModelDelegate
    }
    
    func loadArticles(completion: @escaping NYDALCompletionBlock){
        NYArticlesManager.sharedInstance.getMostViewedArticlesManager(period: 7) { (status, response) in
            if (status == Constants.WebClientResponseStatus.NoInternet){
                let error : NYError = NYError(code: Constants.ErrorCode.NoInternet, title: Constants.ErrorTitle.NoInternet, message: Constants.ErrorMessage.NoInternet)
                self.showError(error: error)
            }
            else{
                self.articles = response as? [NYArticle]
                DispatchQueue.main.async {
                    completion(status,response)
                }
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func dataForIndexPath(indexPath:IndexPath)->Any{
        var data = [String:Any]()
        data[NYBaseCellConstant.Identifier] = NYArticleCell.identifier
        if  let article = articles?[indexPath.row]{
            var imageUrl : String? = nil
            if (article.media != nil && article.media?.count ?? 0 > 0){
                if let media = article.media?[0]{
                    if (media.mediaMetadata != nil && media.mediaMetadata?.count ?? 0 > 0){
                        if let mediaMetaData = media.mediaMetadata?[0]{
                            imageUrl = mediaMetaData.url
                        }
                    }
                }
            }
            data[NYArticleCellConstant.ArticleImageUrl] = imageUrl
            data[NYArticleCellConstant.ArticleTitle] = article.title
            data[NYArticleCellConstant.ArticleDesc] = article.abstract
        }
        return data
    }
    
}
