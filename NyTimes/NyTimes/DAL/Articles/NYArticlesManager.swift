//
//  NYBaseManager.swift
//  Nytimes
//
//  Created by Habib Ali on 26/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

class NYArticlesManager: NYBaseDAL {
    
    static let sharedInstance = NYArticlesManager()
    
    func getMostViewedArticlesManager(period : Int, completionBlock completion:@escaping NYDALCompletionBlock)  {
        
        let endPoint = String.init(format: "%@/%@/%d.json",Constants.Endpoint.mostViewed,Constants.MostViwedAPIParam.AllSections,period)
        var param = [String:Any]()
        param[Constants.APIParam.APIKey] = Constants.NYAuthKey
        self.get(url: endPoint,type: [NYArticle].self,
                  param: param,
                  completion: completion) { (response, cBlock ) in
                   
                    cBlock(Constants.WebClientResponseStatus.Success,response)
                }
    }
    
    
}
