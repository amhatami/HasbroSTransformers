//
//  Generals.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation
import UIKit

let welcomeMsgText : String = "Welcome to\nHasbro’s Transformers\n GAME \nto enter your\nFirst Transfromer\nTAP ON TOP LEFT\n ADD Button"

func getToken(getNew : Bool, api : API)  {
    let defaultssettings = DefaultsSettings()
    var apiToken = defaultssettings.loadSettings(keyName: "token")
    if (apiToken == "" && getNew ) {
        apiToken = "Bearer " + api.getOneToken()
        defaultssettings.saveSettings(keyName: "token", keyValue: apiToken)
    }
    //print(apiToken)
    api.apiToken = apiToken
}

func getURLImagesListAndPreLoadThem(transformersList : [Transformer]) -> [String : UIImage] {
    let imagesList = findImageList(transformers: transformersList)
    var preloadedImage : [String : UIImage] = [:]
    
    for oneImage in imagesList {
        preloadedImage[oneImage.key] = preLoadImage(imagePath: oneImage.value)
    }
    return preloadedImage
}

func preLoadImage(imagePath : String) -> UIImage {
    
    var image : UIImage = UIImage(named: "questionMark") ?? #imageLiteral(resourceName: "questionMark")
    let url = URL(string: imagePath)
    let data = try? Data(contentsOf: url!)
    
    if let imageData = data {
        image = UIImage(data: imageData)!
    } else {
        //keep image init Value
    }
    return image
}

func battleWinner(numA : Int, numD : Int) -> String {
    var winner : String = ""
    if (numA > numD ){
        winner = "Decepticons is winner with \(numA) Win"
    } else if (numA < numD ) {
        winner = "Autobots is Winner with \(numD) Win"
    }  else {
        winner = "Tie No Winner"
    }
    return winner
}


func locateQuickErr(myLine: Int , inputStr : String = "" ) {
    print("===> Guard Error \(inputStr) :\n    file:\(#file)\n    line:\(myLine)\n    function:\(#function) ")
}


func findImageList(transformers : [Transformer]) -> [String : String] {
    var imagesList : [String : String] = [:]
    for oneTransformer in transformers {
        var shouldAdd = true
        for oneImage in imagesList {
            if (oneTransformer.team_icon == oneImage.value) {
                shouldAdd = false
            }
        }
        if shouldAdd {
            imagesList[oneTransformer.team] = oneTransformer.team_icon
        }
    }
    return imagesList
}





