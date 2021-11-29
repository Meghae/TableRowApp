//
//  TableRowDataModel.swift
//  TableRowImages
//
//  Created by Admin on 27/11/21.
//

import UIKit
import Foundation
import ObjectMapper

class TableData:  NSObject, Mappable {
    var title : String?
    var rows : [Rows]?
    required init?(map: Map) {
        super.init()
    }
    required override init() {
        super.init()
    }
    func mapping(map: Map) {
        title <- map["title"]
        rows <- map["rows"]
    }
}

class Rows: NSObject, Mappable {
    var title, titleDescription, imageHref : String?
    required init?(map: Map) {
        super.init()
    }
    required override init() {
        super.init()
    }
    func mapping(map: Map) {
        title <- map["title"]
        titleDescription <- map["description"]
        imageHref <- map["imageHref"]
    }
}
