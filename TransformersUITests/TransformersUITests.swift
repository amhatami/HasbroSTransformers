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
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let predakingElement = cellsQuery.otherElements.containing(.staticText, identifier:"Predaking").element
        //predakingElement.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier:"Optimus prime").element.swipeDown()
        
        let hasbroSTransformersNavigationBar = app.navigationBars["Hasbro’s Transformers"]
        hasbroSTransformersNavigationBar.buttons["Edit"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"hhhhhhhhhhhhh").buttons["Edit"].tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Edit Transformer").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        element.children(matching: .other).element(boundBy: 4)/*@START_MENU_TOKEN@*/.buttons["4"]/*[[".segmentedControls.buttons[\"4\"]",".buttons[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.children(matching: .other).element(boundBy: 3)/*@START_MENU_TOKEN@*/.buttons["4"]/*[[".segmentedControls.buttons[\"4\"]",".buttons[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.children(matching: .other).element(boundBy: 2)/*@START_MENU_TOKEN@*/.buttons["3"]/*[[".segmentedControls.buttons[\"3\"]",".buttons[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        hasbroSTransformersNavigationBar.buttons["Add"].tap()
        saveButton.tap()
        
        let element2 = app.otherElements.containing(.navigationBar, identifier:"Add Transformer").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element2.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.tap()
        element2.children(matching: .other).element(boundBy: 3)/*@START_MENU_TOKEN@*/.buttons["7"]/*[[".segmentedControls.buttons[\"7\"]",".buttons[\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element2.children(matching: .other).element(boundBy: 5)/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".segmentedControls.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element2.children(matching: .other).element(boundBy: 7)/*@START_MENU_TOKEN@*/.buttons["3"]/*[[".segmentedControls.buttons[\"3\"]",".buttons[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element2.children(matching: .other).element(boundBy: 8)/*@START_MENU_TOKEN@*/.buttons["6"]/*[[".segmentedControls.buttons[\"6\"]",".buttons[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        saveButton.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"jjjjjjjjj").element.swipeUp()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Rank: 5\nStrength 1\nCourage: 3\nIntelligence: 3\nSpeed: 5\nFirepower: 8\nSkill: 9\nTeam: Autobots\n"]/*[[".cells.staticTexts[\"Rank: 5\\nStrength 1\\nCourage: 3\\nIntelligence: 3\\nSpeed: 5\\nFirepower: 8\\nSkill: 9\\nTeam: Autobots\\n\"]",".staticTexts[\"Rank: 5\\nStrength 1\\nCourage: 3\\nIntelligence: 3\\nSpeed: 5\\nFirepower: 8\\nSkill: 9\\nTeam: Autobots\\n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        
        let startBattleButton = app.buttons["Start Battle"]
        startBattleButton.tap()
        
        let clickButton = app.alerts["Result"].buttons["Click"]
        clickButton.tap()
        
        let restartGameButton = app.buttons["Restart Game"]
        restartGameButton.tap()
        startBattleButton.tap()
        clickButton.tap()
        restartGameButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.tap()
        
        let rank3Strength3Courage3Intelligence3Speed3Firepower1Skill1TeamDecepticonsStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Rank: 3\nStrength 3\nCourage: 3\nIntelligence: 3\nSpeed: 3\nFirepower: 1\nSkill: 1\nTeam: Decepticons\n"]/*[[".cells.staticTexts[\"Rank: 3\\nStrength 3\\nCourage: 3\\nIntelligence: 3\\nSpeed: 3\\nFirepower: 1\\nSkill: 1\\nTeam: Decepticons\\n\"]",".staticTexts[\"Rank: 3\\nStrength 3\\nCourage: 3\\nIntelligence: 3\\nSpeed: 3\\nFirepower: 1\\nSkill: 1\\nTeam: Decepticons\\n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rank3Strength3Courage3Intelligence3Speed3Firepower1Skill1TeamDecepticonsStaticText.tap()
        rank3Strength3Courage3Intelligence3Speed3Firepower1Skill1TeamDecepticonsStaticText.tap()
        predakingElement.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Predaking").buttons["Delete"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"ssssssssss").buttons["Edit"].tap()
        app.navigationBars["Edit Transformer"].buttons["Hasbro’s Transformers"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
