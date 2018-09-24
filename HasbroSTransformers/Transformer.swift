//
//  Transformer.swift
//  HasbroSTransformers
//
//  Created by Amir on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//
import Foundation


// Transformer Model Encodable & Decodable macth with firebase api
struct Transformer: Encodable & Decodable {
    var id: String
    var name: String
    var team : String
    var strength : Int
    var intelligence : Int
    var speed : Int
    var endurance : Int
    var rank : Int
    var courage : Int
    var firepower : Int
    var skill : Int
    var team_icon: String
    
    // initiat new transformer model from input json or dictionary
    init(json: [String: Any]) {
        id = json["id"] as? String ??  ""
        name = json["name"] as? String ?? ""
        team = json["team"] as? String ?? ""
        strength = json["strength"] as? Int ?? 0
        intelligence = json["intelligence"] as? Int ?? 0
        speed = json["speed"] as? Int ?? 0
        endurance = json["endurance"] as? Int ?? 0
        rank = json["rank"] as? Int ?? 0
        courage = json["courage"] as? Int ?? 0
        firepower = json["firepower"] as? Int ?? 0
        skill = json["skill"] as? Int ?? 0
        team_icon = json["team_icon"] as? String ?? ""
    }
    
    // initiat empty / Best A / Best D of transformer model by String input
    // make options EMPTY BestA BestD and any other string will generate empty transformer
    init(make: String ) {
        if make == "EMPTY" {
            id = ""
            name = ""
            team = ""
            strength = 0
            intelligence =  0
            speed =  0
            endurance =  0
            rank =  0
            courage =  0
            firepower =  0
            skill =  0
            team_icon = ""
        } else if ( make == "BestA" ) {
            id = ""
            name = "TheBestA"
            team = "A"
            strength = 10
            intelligence =  10
            speed =  10
            endurance =  10
            rank =  10
            courage =  10
            firepower =  10
            skill =  10
            team_icon = ""
        } else if ( make == "BestD" ) {
            id = ""
            name = "TheBestD"
            team = "A"
            strength = 10
            intelligence =  10
            speed =  10
            endurance =  10
            rank =  10
            courage =  10
            firepower =  10
            skill =  10
            team_icon = ""
        } else {
            id = ""
            name = ""
            team = ""
            strength = 0
            intelligence =  0
            speed =  0
            endurance =  0
            rank =  0
            courage =  0
            firepower =  0
            skill =  0
            team_icon = ""
        }
    }
    
    // convert transformer to Json or dictionay of [String : Any]
    func toJson() -> [String : Any] {
        return [
            "id": self.id,
            "name": self.name,
            "team": self.team,
            "strength": self.strength,
            "intelligence": self.intelligence,
            "speed": self.speed,
            "endurance": self.endurance,
            "rank": self.rank,
            "courage": self.courage,
            "firepower": self.firepower,
            "skill": self.skill
        ]
    }
    
    // find winner based on mentioned game rules
    func amIWinnerVS(vsTransformer : Transformer) -> String {
        var amIWin : String = "tie"
        let mySelfOverall =  ( self.strength +
            self.intelligence +
            self.speed +
            self.endurance +
            self.rank +
            self.courage +
            self.firepower +
            self.skill ) / 8
        let vsOverall = ( vsTransformer.strength +
            vsTransformer.intelligence +
            vsTransformer.speed +
            vsTransformer.endurance +
            vsTransformer.rank +
            vsTransformer.courage +
            vsTransformer.firepower +
            vsTransformer.skill ) / 8
        
        if (vsTransformer.name.lowercased() == "optimus prime" &&
            self.name.lowercased() != "predaking" &&
            self.name.lowercased() != vsTransformer.name.lowercased()) {
            amIWin = "lose"
        } else if (self.name.lowercased() == "optimus prime" &&
            vsTransformer.name.lowercased() != "predaking" &&
            vsTransformer.name.lowercased() != self.name.lowercased()) {
            amIWin = "win"
        } else if (self.name.lowercased() == "predaking" &&
            vsTransformer.name.lowercased() != "optimus prime" &&
            vsTransformer.name.lowercased() != self.name.lowercased()) {
            amIWin = "win"
        } else if (vsTransformer.name.lowercased() == "predaking" &&
            self.name.lowercased() != "optimus prime" &&
            self.name.lowercased() != vsTransformer.name.lowercased()) {
            amIWin = "lose"
        } else if (self.name.lowercased() == vsTransformer.name.lowercased() ||
            ( self.name.lowercased() == "predaking" &&
                vsTransformer.name.lowercased() == "optimus prime") || ( vsTransformer.name.lowercased() == "predaking" &&
                    self.name.lowercased() == "optimus prime") ) {
            amIWin = "gameover"
        } else if (self.courage >= vsTransformer.courage + 4 && self.strength >=  vsTransformer.strength + 3 ) {
            amIWin = "win"
        } else if (self.courage >= vsTransformer.courage + 4 && self.strength >=  vsTransformer.strength + 3 ) {
            amIWin = "win"
        } else if (self.courage >= vsTransformer.courage + 4 && self.strength >=  vsTransformer.strength + 3 ) {
            amIWin = "win"
        } else if (self.courage + 4 < vsTransformer.courage && self.strength + 3 <  vsTransformer.strength ) {
            amIWin = "lose"
        } else if (self.skill >= vsTransformer.skill + 3 ) {
            amIWin = "win"
        } else if (self.skill + 3 < vsTransformer.skill ) {
            amIWin = "lose"
        } else if (mySelfOverall > vsOverall ) {
            amIWin = "win"
        } else if (mySelfOverall < vsOverall ) {
            amIWin = "lose"
        }
        
        return amIWin
    }
    
    
    // get team name from transformer model
    func getTeamName() -> String {
        return self.team == "A" ? "Autobots" : "Decepticons"
    }
    
    
} //End of struct Transformer: Encodable & Decodable


struct TransformerList: Decodable {
    let transformers : [Transformer]
    
    //    subscript(index: Int) -> Transformer {
    //        get {
    //            return transformers[index]
    //        }
    //    }
} //End of struct TransformerList: Decodable


// class which provide some tools for encapsulation
class TransformerTools {
    
    // separate array of transformers to two arrays for team A and Team D
    func separateByFields(transformers : [Transformer] ) -> ([Transformer],[Transformer]) {
        var transformerInternalA : [Transformer] = []
        var transformerInternalD : [Transformer] = []
        
        for onetransformer in transformers {
            if (onetransformer.team == "A") {
                transformerInternalA.append(onetransformer)
            } else if (onetransformer.team == "D") {
                transformerInternalD.append(onetransformer)
            } else {
                // todo nothing
            }
        }
        return ( sortTransformerArray(transformers: transformerInternalA) , sortTransformerArray(transformers: transformerInternalD) )
    }
    
    
    // sort array trasformer array based on rank
    func sortTransformerArray(transformers : [Transformer]) -> [Transformer] {
        return transformers.sorted(by: { $0.rank > $1.rank })
    }
    
    // join two array of team A and Team B one by one and fill empty spots with empty transdomer
    func makeBattelsList(transformerA : [Transformer],transformerD : [Transformer] ) -> ([Transformer]) {
        var transformerMainInternal : [Transformer] = []
        let lenA = transformerA.count
        let lenD = transformerD.count
        let emptyTransformer = Transformer.init(make: "EMPTY")
        let lenMax = lenA > lenD ? lenA : lenD
        for index in 0 ..< lenMax {
            if (index < lenA) {
                transformerMainInternal.append(transformerA[index])
            } else {
                transformerMainInternal.append(emptyTransformer)
            }
            
            if (index < lenD) {
                transformerMainInternal.append(transformerD[index])
            } else {
                transformerMainInternal.append(emptyTransformer)
            }
        }
        return transformerMainInternal
    }
    
    
} //end of class TransformerTools

