//
//  DataModel.swift
//  DataTrend
//
//  Created by Dinesh Reddy on 23/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import UIKit

struct ResultModel: Codable {
    var dataId: Int
    var quarter: String
    var volume: String

    enum CodingKeys: String, CodingKey {
        case dataId = "_id"
        case quarter
        case volume = "volume_of_mobile_data"
    }
}

struct DataModel: Codable
{
    struct Result: Codable {
        var records:[ResultModel]    }
    var result:Result
    var success: Bool
}

struct DisplayModel {
    var year: String
    var volume: String
}
