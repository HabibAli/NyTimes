//
//  NYApiResponse.swift
//  Nytimes
//
//  Created by Habib Ali on 26/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit
import Foundation

struct NYApiResponse<T:Decodable> :Decodable {
    var status : String?
    var copyright : String?
    var num_results :Int?
    var results : T?
}

struct NYError : Decodable {
    var code : Int?
    var title : String?
    var message : String?
    
    init(code c: Int, title t: String?, message m: String?) {
        code = c
        title = t
        message = m
    }
}

struct NYArticle : Decodable {
    var url : String?
    var adx_keywords : String?
    var column : String?
    var section : String?
    var byline : String?
    var type : String?
    var title : String?
    var abstract : String?
    var published_date : String?
    var source : String?
    var id : Int?
    var asset_id : Int?
    var views : Int?
    //var des_facet : [String]?
    //var org_facet : [String]?
    //var per_facet : [String]?
    //var geo_facet : String?
    var media : [MediaObj]?
}

struct MediaMetaData : Decodable {
    var url : String?
    var format : String?
    var height : Int?
    var width : Int?
}

struct MediaObj : Decodable {
    
    var type : String?
    var subtype : String?
    var caption : String?
    var copyright : String?
    var approved_for_syndication : Int?
    var mediaMetadata : [MediaMetaData]?

    private enum CodingKeys:String, CodingKey{
        case type
        case subtype
        case caption
        case copyright
        case approved_for_syndication
        case mediaMetadata = "media-metadata"
    }
    
    
}

