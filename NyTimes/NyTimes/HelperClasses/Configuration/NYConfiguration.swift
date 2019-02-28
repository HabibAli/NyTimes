//
//  NYConfiguration.swift
//  Nytimes
//
//  Created by Habib Ali on 25/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

#if !swift(>=4.2)
public protocol CaseIterable {
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
}
extension CaseIterable where Self: Hashable {
    static var allCases: [Self] {
        return [Self](AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            var first: Self?
            return AnyIterator {
                let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                if raw == 0 {
                    first = current
                } else if current == first {
                    return nil
                }
                raw += 1
                return current
            }
        })
    }
}
#endif

enum ServerConfig : String {
    case DEV = "DEV"
    case DEMO = "DEMO"
    case QA = "QA"
    case STAGE = "STAGE"
    case PROD = "PROD"
}

extension ServerConfig: CaseIterable {}

let defaultServerConfig : ServerConfig = .PROD
let defaultServer : String = "http://api.nytimes.com/svc/mostpopular/v2/"

class NYConfiguration: NSObject {
    var resourceFileDictionary: NSDictionary?
    
    private var _config : ServerConfig?
    
    var config : ServerConfig {
        get {
            var conf : ServerConfig? = _config
            if conf == nil {
                let userDefaults = UserDefaults.standard
                
                guard let c : String = userDefaults.object(forKey: Constants.KeyUserDefault.ServerConfigKey) as? String else {
                    self.config = defaultServerConfig
                    return _config!
                }
                
                conf = ServerConfig(rawValue: c)
                self.config = conf!
            }
    
            return _config!
        }
        set {
            
            _config = newValue
            let userDefaults = UserDefaults.standard
            userDefaults.set(_config?.rawValue, forKey: Constants.KeyUserDefault.ServerConfigKey)
            userDefaults.synchronize()
        }
    }
    
    
    //MARK : Singleton
    private override init() {
        super.init()
        //Load content of Info.plist into resourceFileDictionary dictionary
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            resourceFileDictionary = NSDictionary(contentsOfFile: path)
        }
    }
    
    static let sharedInstance = NYConfiguration()
    
    //Returns value from info.plist file on basis of Development Envoirnment
    func envValue(forKey : String) -> String {
        
        var configValue : String = ""
        var configDictionary : Dictionary? = resourceFileDictionary?.object(forKey: forKey) as? Dictionary<String,String>
        
        
        if(configDictionary?[config.rawValue] != nil)
        {
            configValue = (configDictionary?[config.rawValue])!
        }
        else {
            configValue = defaultServer
        }
    
        return configValue
    }
    
    func shouldShowServerConfig() -> Bool {
        if let dict = resourceFileDictionary, let shouldShow = dict.object(forKey: "ShowServerConfig") as? Bool{
            return shouldShow
        }
        return false
    }
}
