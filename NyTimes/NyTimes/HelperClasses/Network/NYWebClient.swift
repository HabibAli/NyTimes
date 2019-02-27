//
//  NYWebClient.swift
//  Nytimes
//
//  Created by Habib Ali on 25/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class NYWebClient: NSObject {
    
    //var baseURL : String?
    var sessionId : String?
    
    //MARK: - Singleton
    private override init()
    {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Constants.API.RequestTimeOut
        _ = Alamofire.SessionManager(configuration: configuration)
    }
    
    static let sharedInstance = NYWebClient()
    
    func post(uri: String, param: [String : Any]?, completion completionBlock:@escaping  NYResponseCompletionBlock)
    {
        sendRequest(httpMethod: .post, uri: uri, param: param, completion: completionBlock)
    }
    
    func put(uri: String, param: [String : Any]?, completion completionBlock:@escaping  NYResponseCompletionBlock)
    {
        sendRequest(httpMethod: .put, uri: uri, param: param, completion: completionBlock)
    }
    
    func patch(uri: String, param: [String : Any]?, completion completionBlock:@escaping  NYResponseCompletionBlock)
    {
        sendRequest(httpMethod: .patch, uri: uri, param: param, completion: completionBlock)
    }
    
    func  get(uri: String, param: [String : Any]?, completion completionBlock:@escaping NYResponseCompletionBlock)
    {
        sendRequest(httpMethod: .get, uri: uri, param: param,completion: completionBlock)
    }
    
    func  delete(uri: String, param: [String : Any]?, completion completionBlock:@escaping NYResponseCompletionBlock)
    {
        sendRequest(httpMethod: .delete, uri: uri, param: param,completion: completionBlock)
    }
    
    func uploadData(filesToUpload: [String:Data], uri: String, param: [String : Any]?, completion completionBlock:@escaping NYResponseCompletionBlock) {
        sendRequest(httpMethod: .patch, uri: uri, param: param, completion: completionBlock,filesToUpload: filesToUpload)
    }
    
    private func sendRequest(httpMethod: HTTPMethod, uri: String, param: Parameters?, completion  completionBlock:@escaping  NYResponseCompletionBlock, filesToUpload: [String:Data]? = nil)
    {
        guard Connectivity.isConnectedToInternet else {
//            log.error("No Internet Available")
            var retryDictionary = [Constants.NoInternetKey.HttpMethod : httpMethod.rawValue,
                                   Constants.NoInternetKey.Url : uri,
                                   Constants.NoInternetKey.Param: param ?? [:]] as [String : Any]
            if filesToUpload != nil {
                retryDictionary[Constants.NoInternetKey.FilesToUpload] = filesToUpload
            }
            
            let retryDate : Data = NSKeyedArchiver.archivedData(withRootObject: retryDictionary)
            completionBlock(Constants.WebClientResponseStatus.NoInternet,retryDate)
            return
        }
        //Creating complet Url
        let url = NYConfiguration.sharedInstance.envValue(forKey: Constants.API.BaseURLKey) + uri
        
//        log.debug("Server call: \(url)")
//        log.debug("Param: \(String(describing: param))")
        
        var httpHeaders : [String:String] = [:]
        var urlEncoding: ParameterEncoding = JSONEncoding.default
        
        if filesToUpload != nil{
            httpHeaders["Content-Type"] = "multipart/form-data"
        }
        else if httpMethod == .put || httpMethod == .post || httpMethod == .patch{
            httpHeaders["Content-Type"] = "application/json"
        }else{
            httpHeaders["Content-Type"] = "application/x-www-form-urlencoded"
            urlEncoding = URLEncoding.default
        }

        /*if let token = NYAppSession.currentSession.token , !(NYAppSession.currentSession.token?.isEmpty)!
        {
            httpHeaders["Authorization"] = "Bearer " + token
        }
        else {
        }*/
        
        if filesToUpload == nil{
            Alamofire.request(url,
                              method: httpMethod,
                              parameters : param,
                              encoding: urlEncoding,
                              headers:httpHeaders).validate().responseJSON { (response) -> Void in
                                self.handleCompletion(response: response, completion: completionBlock)
            }
        }else{
            
            Alamofire.upload(multipartFormData: { (formData) in
                for key in filesToUpload!.keys{
                    formData.append(filesToUpload![key]!, withName: key, fileName: key, mimeType: "image/jpg")
                }
                if let tmpParam = param{
                    for (key,value) in tmpParam{
                        formData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }
            }, usingThreshold: UInt64.init(), to: url, method: httpMethod, headers: httpHeaders) { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        self.handleCompletion(response: response, completion: completionBlock)
                    }
                case .failure(let error):
                    completionBlock(error.localizedDescription,Data())
                    break
                }
            }
        }
    }
    
    func handleCompletion(response: DataResponse<Any>, completion  completionBlock:@escaping  NYResponseCompletionBlock) {
        guard response.result.isSuccess else {
            
            //TODO: Handle 401 UnAuthorize
            
//            log.error("ErrorCode: \(String(describing:  response.response?.statusCode))")
//            log.error("Message: \(String(describing: response.result.error?.localizedDescription))")
            
            let errorCode : String = "ErrorCode: \(String(describing: response.response?.statusCode))"
            let errorMessage : String = "Message: \(String(describing: response.result.error?.localizedDescription))"
            
            var error : String = errorCode + "\n" + errorMessage //Constants.WebClientResponseStatus.Error
            
            if response.response?.statusCode == 401 {
                //Handle 401 UnAuthorize
//                log.error("Un Authorize")
                error = Constants.WebClientResponseStatus.UnAuthorize
            }
            
            completionBlock(error,Data())
            return
        }
        
        
        //response.data
        guard let responseJSON = response.result.value as? [String: Any] else {
            
//            log.error("Invalid JSON tag information received from the service")
            
            completionBlock(Constants.WebClientResponseStatus.InvalidJSON,Data())
            return
        }
        
//        log.debug("JSON Response from Weblayer \(responseJSON)")
        
        guard let _ = response.data else {
//            log.error("No data available in response")
            completionBlock(Constants.WebClientResponseStatus.NoData, Data())
            return
        }
        
        completionBlock(Constants.WebClientResponseStatus.Success,response.data!)
    }
}
