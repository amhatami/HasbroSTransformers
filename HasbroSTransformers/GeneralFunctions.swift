//
//  GeneralFunctions.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation
import UIKit

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


