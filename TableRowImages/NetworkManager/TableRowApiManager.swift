//
//  TableRowApiManager.swift
//  TableRowImages
//
//  Created by Admin on 27/11/21.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class TableRowApiManager: NSObject {
    typealias tableDetailsCallBack = (TableData?,String?)-> Void
    class func getTableDateRowDetails(urlString : String?, onCompletion : @escaping tableDetailsCallBack){
        
        let session = URLSession.shared
        if let url = URL(string: urlString ?? ""){
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                let str = String(decoding: data, as: UTF8.self)
                if let res = Mapper<TableData>().map(JSONString: str) {
                    onCompletion(res, nil)
                }
            })
            task.resume()
        }
    }
}
