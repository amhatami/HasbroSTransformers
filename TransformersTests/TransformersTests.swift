//
//  TransformersTests.swift
//  TransformersTests
//
//  Created by Pooya on 2018-09-24.
//  Copyright © 2018 Amir. All rights reserved.
//

import XCTest
@testable import HasbroSTransformers

class TransformersTests: XCTestCase {

    var transformerOne : Transformer!
    var transformerTwo : Transformer!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBattleBestToBest()  {
        transformerOne = Transformer(make: "BestA")
        transformerTwo = Transformer(make: "BestD")
        let result = transformerOne.amIWinnerVS(vsTransformer: transformerTwo)
        XCTAssert(result == "tie")
    }

    func testBattleBlasterToBest()  {
        transformerOne = Transformer(json: ["name":"Soundwave" ,
                                            "id" : "",
                                            "team" : "A",
                                            "strength" : 8,
                                            "intelligence" :  9,
                                            "speed" :  2,
                                            "endurance" : 6,
                                            "rank" : 7,
                                            "courage" : 5,
                                            "firepower" : 6,
                                            "skill" : 10,
                                            "team_icon" : ""
                                                        ])
        transformerTwo = Transformer(json: ["name":"Bluestreak" ,
                                            "id" : "",
                                            "team" : "D",
                                            "strength" : 6,
                                            "intelligence" :  6,
                                            "speed" :  7,
                                            "endurance" : 9,
                                            "rank" : 5,
                                            "courage" : 2,
                                            "firepower" : 9,
                                            "skill" : 7,
                                            "team_icon" : ""
                                                        ])
        let result = transformerOne.amIWinnerVS(vsTransformer: transformerTwo)
        XCTAssert(result == "win")
    }

    
    func testBattlePredakingVSOptimusPrime()  {
        transformerOne = Transformer(json: ["name":"Predaking" ,
                                            "id" : "",
                                            "team" : "A",
                                            "strength" : 8,
                                            "intelligence" :  9,
                                            "speed" :  2,
                                            "endurance" : 6,
                                            "rank" : 7,
                                            "courage" : 5,
                                            "firepower" : 6,
                                            "skill" : 10,
                                            "team_icon" : ""
            ])
        transformerTwo = Transformer(json: ["name":"Optimus Prime" ,
                                            "id" : "",
                                            "team" : "D",
                                            "strength" : 6,
                                            "intelligence" :  6,
                                            "speed" :  7,
                                            "endurance" : 9,
                                            "rank" : 5,
                                            "courage" : 2,
                                            "firepower" : 9,
                                            "skill" : 7,
                                            "team_icon" : ""
            ])
        let result = transformerOne.amIWinnerVS(vsTransformer: transformerTwo)
        XCTAssert(result == "gameover")
    }

}
