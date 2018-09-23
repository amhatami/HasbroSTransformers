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

public extension UIButton {
    
    func customizeButtonG1() {
        // change UIbutton propertie
        let c1GreenColor = (UIColor(red: -0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        let c2GreenColor = (UIColor(red: 0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        self.backgroundColor = UIColor.yellow
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 0.8
        self.layer.borderColor = c1GreenColor.cgColor
        
        self.layer.shadowColor = c2GreenColor.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
//        self.setImage(UIImage(named:"3d-glass-refresh-32X32.png"), for: .normal)
//        self.imageEdgeInsets = UIEdgeInsets(top: 6,left: 100,bottom: 6,right: 14)
//        self.titleEdgeInsets = UIEdgeInsets(top: 0,left: -30,bottom: 0,right: 34)
        
    }
    
    
    
}


public extension  UITextField {
    
    
    func shake(horizantaly:CGFloat = 0  , Verticaly:CGFloat = 0) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - horizantaly, y: self.center.y - Verticaly ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + horizantaly, y: self.center.y + Verticaly ))
        
        
        self.layer.add(animation, forKey: "position")
        
    }
    
    
    func customizeTextField() {
        // change UIbutton propertie
        let c1GreenColor = (UIColor(red: -0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        let c2GreenColor = (UIColor(red: 0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        self.backgroundColor = UIColor.yellow
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 0.8
        self.layer.borderColor = c1GreenColor.cgColor
        
        self.layer.shadowColor = c2GreenColor.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    func uncustomizeTextField(backGroundColor : UIColor ) {
        // change UIbutton propertie
        self.backgroundColor = backGroundColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
}

}


    class Pulsing: CALayer {
        
        var animationGroup = CAAnimationGroup()
        
        var initialPulseScale:Float = 0
        var nextPulseAfter:TimeInterval = 0
        var animationDuration:TimeInterval = 1.5
        var radius:CGFloat = 200
        var numberOfPulses:Float = Float.infinity
        
        override init(layer : Any) {
            super.init(layer: layer)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        init (numberOfPulses:Float = Float.infinity, radius:CGFloat , position:CGPoint){
            super.init()
            
            self.backgroundColor = UIColor.black.cgColor
            self.contentsScale = UIScreen.main.scale
            self.opacity = 0
            self.radius = radius
            self.numberOfPulses = numberOfPulses
            self.position = position
            
            self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            self.cornerRadius = radius
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.setupAnimatiomnGroup()
                
                DispatchQueue.main.async {
                    self.add(self.animationGroup, forKey: "pulse")
                }
            }
            
        }
        
        func creatScaleAnimation () -> CABasicAnimation {
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
            scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
            scaleAnimation.toValue = NSNumber(value: 1)
            scaleAnimation.duration = animationDuration
            
            return scaleAnimation
            
        }
        
        func createOpacityAnimation () -> CAKeyframeAnimation {
            
            let opacityAnimation =  CAKeyframeAnimation(keyPath: "opacity")
            opacityAnimation.duration = animationDuration
            opacityAnimation.values = [0.4, 0.8 , 0.0]
            opacityAnimation.keyTimes = [0, 0.2 , 1]
            
            return opacityAnimation
        }
        
        func setupAnimatiomnGroup() {
            self.animationGroup = CAAnimationGroup()
            self.animationGroup.duration = animationDuration + nextPulseAfter
            self.animationGroup.repeatCount = numberOfPulses
            
            let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            self.animationGroup.timingFunction = defaultCurve
            
            self.animationGroup.animations = [creatScaleAnimation(), createOpacityAnimation()]
        }
}
