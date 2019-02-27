//  NYBaseDAL.swift
//  Nytimes
//
//  Created by Habib Ali on 26/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class NYBaseDAL: NSObject {

    func delete<T>(isHidden: Bool? = nil, url:String, type:T.Type? = nil, param: [String:Any]?,completion completionBlock: @escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        
        NYWebClient.sharedInstance.delete(uri: url, param: param) { (status, responseData) in
            self.handleAPIResponse(isHidden: (isHidden == nil ? false : true),status: status, type:type, responseData: responseData, completion: completionBlock, success: successBlock)
        }
    }
    
    func get<T>(isHidden: Bool? = nil, url: String, type:T.Type? = nil, param: [String:Any]?,completion completionBlock: @escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        
        NYWebClient.sharedInstance.get(uri: url, param: param) { (status, responseData) in
            self.handleAPIResponse(isHidden: (isHidden == nil ? false : true),status: status, type:type, responseData: responseData, completion: completionBlock, success: successBlock)
        }
    }

    func post<T>(isHidden: Bool? = nil, url: String, type:T.Type? = nil, param: [String:Any]?,completion completionBlock: @escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        
        NYWebClient.sharedInstance.post(uri: url, param: param) { (status, responseData) in
            self.handleAPIResponse(isHidden: (isHidden == nil ? false : true), status: status, type:type, responseData: responseData, completion: completionBlock, success: successBlock)
        }
    }
    
    func put<T>(isHidden: Bool? = nil, url: String, type:T.Type? = nil, param: [String:Any]?,completion completionBlock: @escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        
        NYWebClient.sharedInstance.put(uri: url, param: param) { (status, responseData) in
            self.handleAPIResponse(isHidden: (isHidden == nil ? false : true),status: status, type:type, responseData: responseData, completion: completionBlock, success: successBlock)
        }
    }
    
    func patch<T>(isHidden: Bool? = nil, url: String, type:T.Type? = nil, param: [String:Any]?,completion completionBlock: @escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        
        NYWebClient.sharedInstance.patch(uri: url, param: param) { (status, responseData) in
            self.handleAPIResponse(isHidden: (isHidden == nil ? false : true),status: status, type:type, responseData: responseData, completion: completionBlock, success: successBlock)
        }
    }
    
    func upload<T>(isHidden: Bool? = nil, filesToUpload: [String:Data], url: String, type:T.Type? = nil, param: [String:Any]?,completion completionBlock: @escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        
        NYWebClient.sharedInstance.uploadData(filesToUpload:filesToUpload, uri: url, param: param) { (status, responseData) in
            self.handleAPIResponse(isHidden: (isHidden == nil ? false : true), status: status, type:type, responseData: responseData, completion: completionBlock, success: successBlock)
        }
    }
    
    func handleNoInternet<T>(responseData: Data, type:T.Type? = nil, completion completionBlock: @escaping NYDALCompletionBlock, success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        let response = NSKeyedUnarchiver.unarchiveObject(with: responseData) as! [String : Any]
        
        /*
        if let vc = ((UIApplication.shared.delegate?.window)!)!.rootViewController{
            let noInternetVC: NYNoInternetViewController = Utility.mainStoryboard.instantiateViewController(withIdentifier: "NYNoInternetViewController") as! NYNoInternetViewController
            noInternetVC.onRetryAction = {
                () -> Void in
                DispatchQueue.main.async {
                    SVProgressHUD.show()
                    UIApplication.shared.beginIgnoringInteractionEvents()
                    let param : [String : Any]? = response[Constants.NoInternetKey.Param] as? [String : Any]
                    let url : String = response[Constants.NoInternetKey.Url] as! String
                    
                    if let filesToUpload = response[Constants.NoInternetKey.FilesToUpload] {
                        self.upload(filesToUpload: filesToUpload as! [String : Data], url: url,type: type, param: param, completion: completionBlock, success: successBlock)
                    }
                    else {
                        let requestType : HTTPMethod = HTTPMethod(rawValue: response[Constants.NoInternetKey.HttpMethod] as! String)!
                        
                        switch requestType {
                        case .post:
                            self.post(url: url, type: type, param: param, completion: completionBlock, success: successBlock)
                            break
                        case .put:
                            self.put(url: url, type: type, param: param, completion: completionBlock, success: successBlock)
                            break
                        case .delete:
                            self.delete(url: url, type: type, param: param, completion: completionBlock, success: successBlock)
                            break
                        case .patch:
                            self.patch(url: url, type: type, param: param, completion: completionBlock, success: successBlock)
                            break
                        default:
                            self.get(url: url, type: type, param: param, completion: completionBlock, success: successBlock)
                            break
                        }
                    }
                }
            }
            
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
            vc.present(noInternetVC, animated: true, completion: nil)*/
        //}
    }
    
    func handleAPIResponse<T>(isHidden: Bool? = nil, status: String, type:T.Type? = nil,responseData: Any,completion completionBlock:@escaping NYDALCompletionBlock,success successBlock:@escaping NYDALSuccessBlock) -> Void where T : Decodable{
        if status != Constants.WebClientResponseStatus.Success {
            if status == Constants.WebClientResponseStatus.NoInternet  {
                //In Case of Network Fail.
                if (isHidden == true) {
                    let error : NYError = NYError(code: Constants.ErrorCode.NoInternet, title: Constants.ErrorTitle.NoInternet, message: Constants.ErrorMessage.NoInternet)
                    completionBlock(status, error)
                }
                else {
                    handleNoInternet(responseData: responseData as! Data,type:type, completion: completionBlock, success: successBlock)
                }
                return
            }
            else if status == Constants.WebClientResponseStatus.UnAuthorize {
                
                //TODO: Logout
                //Logout will show its own alert message
                //For now showing this message
                let error : NYError = NYError(code: Constants.ErrorCode.UnAuthorize, title: Constants.ErrorTitle.UnAuthorize, message: Constants.ErrorMessage.UnAuthorize)
                completionBlock(Constants.WebClientResponseStatus.Fail,error)
            }
            
            else {
                let error : NYError = NYError(code: Constants.ErrorCode.GenralError, title: Constants.ErrorTitle.GenralError, message: status)
                completionBlock(status, error)
            }
        }
        else {
                do{
                    let decoder = JSONDecoder()
                    /*let dateFormatter = DateFormatter()
                    dateFormatter.calendar = Calendar(identifier: .iso8601)
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                    
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    */
                    let response : NYApiResponse<T>  = try decoder.decode(NYApiResponse<T>.self, from: responseData as! Data)
//                    print(response)
                    
                    if response.status! == Constants.WebClientResponseStatus.Success{
                        successBlock(response.results,completionBlock)
                    }
                    else {
                        completionBlock(Constants.WebClientResponseStatus.Fail,response.status ?? NYError(code: Constants.ErrorCode.GenralError, title: Constants.ErrorTitle.GenralError, message: "Response fail with no Error"))
                    }
                }
                catch let error as NSError {
//                    log.error(error)
                    completionBlock(Constants.WebClientResponseStatus.Fail,NYError(code: Constants.ErrorCode.GenralError, title: Constants.ErrorTitle.GenralError, message: "Un able to parse response."))
                }
        }
            
        
    }
    
}
