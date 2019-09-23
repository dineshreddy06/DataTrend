//
//  NetworkManager.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 23/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    static var headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "*/*"
    ]
    
    static func fetchData(url: String, completion: @escaping (_ result: Data) -> Void) {
        AF.request(url).responseJSON {responseData in
            if let data = responseData.data {
                completion(data)
            } else {
                completion(Data())
            }
        }
    }
    
    static func postData(url: String, body: [String: AnyObject], completion: @escaping (_ result: Data) -> Void) {
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON {responseData in
            if let data = responseData.data {
                completion(data)
            } else {
                completion(Data())
            }
        }
    }
    
    static func putData(url: String, body: [String: AnyObject], completion: @escaping (_ result: Data) -> Void) {
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON {responseData in
            if let data = responseData.data {
                completion(data)
            } else {
                completion(Data())
            }
        }
    }
}
