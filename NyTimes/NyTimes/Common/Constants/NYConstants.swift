//
//  NYConstants.swift
//  Nytimes
//
//  Created by Habib Ali on 25/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

typealias NYResponseCompletionBlock = (_ success: String, _ response: Data) -> Void
typealias NYDALCompletionBlock = (_ success: String, _ response: Any) -> Void
typealias NYDALSuccessBlock = (_ response: Any,_ success: NYDALCompletionBlock) -> Void

struct Constants {
    
    static let NYAuthKey = "AhF4GX5ERHmvlPSyQD8EQA" //should be obfuscated
    
    
    
    struct Endpoint {
        static let mostViewed = "mostviewed"
        
    }
    
    struct API {
        static let BaseURLKey = "BaseAPIURL"
        static let RequestTimeOut = 10.0
    }
    
    struct WebClientResponseStatus {
        static let Success = "OK"
        static let Fail = "Fail"
        static let Error = "error"
        static let NoInternet = "NoInternet"
        static let UnAuthorize = "UnAuthorize"
        static let InvalidJSON = "InvalidJSON"
        static let NoData = "NoData"
    }
    
    struct ErrorCode {
        static let GenralError : Int = 1001
        static let NoInternet  : Int = 1002
        static let UnAuthorize : Int = 401
        static let Validation  : Int = 1003
        
    }
    struct ErrorTitle {
        static let GenralError : String = "Error"
        static let NoInternet : String = "No Internet"
        static let UnAuthorize : String = "Session not found"
        static let Validation   : String = "Error"
    }
    
    struct ErrorMessage {
        static let GenralError : String = "Oops, it looks like something went wrong. Please try again later."
        static let NoInternet : String = "Please check your internet connection"
        static let UnAuthorize : String = "Please login again"
    }
    
    struct NoInternetKey {
        static let Url = "url"
        static let Param = "param"
        static let HttpMethod = "httpMethod"
        static let FilesToUpload = "filesToUpload"
    }
    
    struct DALErrorResponseKey {
        static let Title = "Title"
        static let Message = "Message"
    }
    
    struct APIParam {
        static let APIKey = "api-key"
    }
    
    struct MostViwedAPIParam{
        static let AllSections = "all-sections"
    }
    
    struct KeyUserDefault {
        static let Token = "token"
        static let User = "user"
        static let TouchId = "touchId"
        static let AppState = "AppState"
        static let SelectedAnswer = "SelectedAnswers"
        static let ServerConfigKey = "ServerConfig"
    }
}
