//
//  DataTrendTests.swift
//  DataTrendTests
//
//  Created by Dinesh Reddy on 21/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import XCTest
@testable import DataTrend

class DataTrendTests: XCTestCase {

    fileprivate var dataTrends: MockDataService?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dataTrends = MockDataService()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataTrends = nil
        super.tearDown()
    }
    
    func testData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        dataTrends?.filename = "data"
        dataTrends?.fetchDataWithLimit(limit: 5, completion: { (result: [ResultModel], error: String?) in
            XCTAssert(result.count > 0)
        })
    }
}

class MockDataService: DataTrend.DataProtocol {
    var filename = ""
    func readData(filename: String) -> Data? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                  return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
              } catch {
                   // handle error
              }
        }
        return Data()
    }
    
    func fetchDataWithLimit(limit: Int, completion: @escaping (_ result: [ResultModel], _ error: String?) -> Void) {
        if let result: ResultModel = try? JSONDecoder().decode(ResultModel.self, from: readData(filename: filename) ?? Data()) {
            let results: [ResultModel] = [result]
            completion(results, "")
        }
    }
}
