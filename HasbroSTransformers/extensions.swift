//
//  extensions.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-23.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit


extension UIColor {
    
    static let lightPink = UIColor(hex: "ffc0cb", alpha: 1)
    static let mistyRose = UIColor(hex: "ffe4e1")
    static let dustyDarkGreen  = UIColor(hex: "008080")
    static let lightlightPink = UIColor(hex: "d3ffce")
    static let lightPurple = UIColor(hex: "e6e6fa")
    
    convenience init(red : Int , green : Int , Blue: Int , alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(Blue) / 255.0,
            alpha : alpha
        )
    }
    
    convenience init(hex : String , alpha: CGFloat = 1.0) {
        
        let index0 = hex.index(hex.startIndex, offsetBy: 0)
        let index1 = hex.index(hex.startIndex, offsetBy: 1)
        let index2 = hex.index(hex.startIndex, offsetBy: 2)
        let index3 = hex.index(hex.startIndex, offsetBy: 3)
        let index4 = hex.index(hex.startIndex, offsetBy: 4)
        let index5 = hex.index(hex.startIndex, offsetBy: 5)
        
        let redHexStr = String(hex[index0...index1])     // "12"
        let greedHexStr = String(hex[index2...index3])     // "34"
        let blueHexStr = String(hex[index4...index5])     // "56"
        
        let red = UInt8(redHexStr, radix: 16)
        let green = UInt8(greedHexStr, radix: 16)
        let blue = UInt8(blueHexStr, radix: 16)
        
        self.init(
            red: CGFloat(red!) / 255.0,
            green: CGFloat(green!) / 255.0,
            blue: CGFloat(blue!) / 255.0,
            alpha : alpha
        )
        
    }
    
    convenience init(hexint: Int , alpha : CGFloat = 1.0) {
        self.init(
            red : (CGFloat((hexint >> 16) & 0xFF)),
            green : (CGFloat((hexint >> 8) & 0xFF)),
            blue : (CGFloat(hexint & 0xFF)),
            alpha : alpha
        )
    }
    
    static func rgb(red: CGFloat , green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func hex(hex: Int, alpha : CGFloat = 1.0) -> UIColor {
        return UIColor(
            red : CGFloat((hex >> 16) & 0xFF),
            green : CGFloat((hex >> 8) & 0xFF),
            blue : CGFloat(hex & 0xFF),
            alpha : alpha
        )
    }
    
}
