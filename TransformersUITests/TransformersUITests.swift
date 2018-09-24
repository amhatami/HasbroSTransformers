//
//  TransformersUITests.swift
//  TransformersUITests
//
//  Created by Pooya on 2018-09-24.
//  Copyright © 2018 Amir. All rights reserved.
//

import XCTest
@testable import HasbroSTransformers


class TransformersUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        
        
        let app = XCUIApplication()
        app.buttons["Start Battle"].tap()
        app.alerts["Result"].buttons["Click"].tap()
        
        let hasbroSTransformersNavigationBar = app.navigationBars["Hasbro’s Transformers"]
        hasbroSTransformersNavigationBar.buttons["Help"].tap()
        app.navigationBars["UIView"].buttons["Hasbro’s Transformers"].tap()
        hasbroSTransformersNavigationBar.buttons["Edit"].tap()
        hasbroSTransformersNavigationBar.buttons["Done"].tap()
        app.buttons["Restart Game"].tap()

    }

}
