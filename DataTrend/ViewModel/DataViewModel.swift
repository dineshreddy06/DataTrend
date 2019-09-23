//
//  DataViewModel.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 23/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

protocol DataProtocol : class {
    func fetchDataWithLimit(limit: Int, completion: @escaping (_ result: [ResultModel], _ error: String?) -> Void)
}

class DataViewModel: DataProtocol {
    let parser = ParseManager()
    
    func fetchDataWithLimit(limit: Int, completion: @escaping (_ result: [ResultModel], _ error: String?) -> Void) {
        NetworkManager.fetchData(url: parser.prepareURL(withLimit: limit)) { (result: Data) in
            let data = self.parser.parseDatatResult(json: result)
            completion(data.0, data.1)
        }
    }
}
