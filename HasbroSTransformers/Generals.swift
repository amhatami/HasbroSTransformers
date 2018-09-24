//
//  Generals.swift
//  HasbroSTransformers
//
//  Created by Amir on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation
import UIKit

// welcome message in case of empty list to give initial idea to user
let welcomeMsgText : String = "Welcome to\nHasbro’s Transformers\n GAME \nto enter your\nFirst Transfromer\nTAP ON TOP Right\n ADD Button"

// get token from UserDefaults.standard
// for the first time generate token over firebase api
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

// find list of images and pre load them to speed up app interface
func getURLImagesListAndPreLoadThem(transformersList : [Transformer]) -> [String : UIImage] {
    let imagesList = findImageList(transformers: transformersList)
    var preloadedImage : [String : UIImage] = [:]
    
    for oneImage in imagesList {
        preloadedImage[oneImage.key] = preLoadImage(imagePath: oneImage.value)
    }
    return preloadedImage
}

// pre-load one image from url and keep it on memory
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

// find list of images inside an array of Transformer
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

// find battle Winner and creat a message for alert popup
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


// send error source information to console
func locateQuickErr(myLine: Int , inputStr : String = "" ) {
    print("===> Guard Error \(inputStr) :\n    file:\(#file)\n    line:\(myLine)\n    function:\(#function) ")
}







