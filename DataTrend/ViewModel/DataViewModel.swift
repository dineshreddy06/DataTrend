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

extension DataViewModel {
    func convertData(data: [ResultModel]) -> [DisplayModel] {
        var yearArray = [String]()
        for obj in data {
            yearArray.append(String(obj.quarter.prefix(4)))
        }
        yearArray = Array(Set(yearArray)).sorted()
        
        var groupArray: [DisplayModel] = []
        for year in yearArray {
            let yearObj = data.filter{$0.quarter.contains(year)}
            let vol = yearObj.reduce(0) {$0 + (Double($1.volume) ?? 0)}
            let resultObj = DisplayModel(year: year, volume: "\(vol)", isUsageDecreased: isUsageDecreased(year: year, withData: data))
            groupArray.append(resultObj)
        }
        return groupArray
    }
    
    func isUsageDecreased(year: String, withData data: [ResultModel]) -> Bool {
        let yearObj = data.filter{$0.quarter.contains(year)}.sorted(by: {$0.quarter > $1.quarter})
        let volArray = yearObj.map {$0.volume}
        return !volArray.isSorted()
    }
}
