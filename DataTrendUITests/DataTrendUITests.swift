//
//  DataTrendUITests.swift
//  DataTrendUITests
//
//  Created by Dinesh Reddy on 21/09/19.
//  Copyright © 2019 Dinesh Reddy. All rights reserved.
//

import XCTest

class DataTrendUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        sleep(3)
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"2011")/*[[".cells.containing(.staticText, identifier:\"14.638703\")",".cells.containing(.staticText, identifier:\"2011\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.images["warning"].tap()
        app.alerts["Oops!"].scrollViews.otherElements.buttons["OK"].tap()
        sleep(1)
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["0.000927"]/*[[".cells.staticTexts[\"0.000927\"]",".staticTexts[\"0.000927\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        sleep(2)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
