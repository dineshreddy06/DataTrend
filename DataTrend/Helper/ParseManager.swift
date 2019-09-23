//
//  ParseManager.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 23/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

struct API {
    static let HOST = "https://data.gov.sg/"
    static let trendsAPI = "api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=%@"
}

class ParseManager: NSObject {
    
    func prepareURL(withLimit limit: Int = 0) -> String {
        return API.HOST + API.trendsAPI.replacingOccurrences(of: "%@", with: "\(limit)")
    }
    
    func parseDatatResult(json: Data) -> ([ResultModel], String?) {
        let result: [ResultModel] = []
        var error: String?
        
        if let data = try? JSONDecoder().decode(DataModel.self, from: json) {
            let response = data
            if response.success {
                return (response.result.records, error)
            } else {
                error = "Failed to fetch data!!"
            }
        } else {
            error = "Invalid data!!"
        }
        return (result, error)
    }
}
