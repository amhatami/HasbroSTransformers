//
//  extensions.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-23.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit

//
extension ViewController : DataCollectionProtocol {
    func passData(index: Int) {
        
        print("hello paddData \(index)")
        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsAddOrEdit") as? DetailsViewController
        vc?.keyIndex = transformerBattles[index].id
        vc?.oneTransformer = transformerBattles[index]
        vc?.typeValue = "Edit"
        print("Delete")
        print(transformerBattles[index].id)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func deleteData(index: Int) {
        print("hello deleteData \(index)")
        print("Delete")
        print(transformerBattles[index].id)
        _ = api.deleteTransformer(transformer: transformerBattles[index])
        transformerBattles.remove(at: index)
        let transformerMain = api.getTransformers()
        let (transformerA , transformerD) = transformerTools.separateByFields(transformers: transformerMain)
        transformerBattles = transformerTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        collectionView.reloadData()
    }
}//end of extension  UIButton


extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let heightVal = self.view.frame.height
        let widthVal = self.view.frame.width
        let heightMul : CGFloat = (heightVal < widthVal) ? 2.0 : 4.0
        
        return CGSize(width: bounds.width / 2  , height:  bounds.height / heightMul )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}//end of extension  ViewController


 //return color from RGB and HEX
extension UIColor {
    
    //few ready colors
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
    
}//end of extension  UIColor


//Extention two add customization for buttons
public extension UIButton {
    
    func customizeEditButton() {
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

    func customizeDeleteButton() {
        let c1GreenColor = (UIColor(red: -0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        let c2GreenColor = (UIColor(red: 0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        self.backgroundColor = UIColor.red
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 0.8
        self.layer.borderColor = c1GreenColor.cgColor
        self.layer.shadowColor = c2GreenColor.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    func customizeBattleButton() {
        let c1GreenColor = (UIColor(red: -0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Stainless-Steel.jpg")!)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.8
        self.layer.borderColor = c1GreenColor.cgColor
        self.layer.shadowColor = UIColor.yellow.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    func shake(horizantaly:CGFloat = 0  , Verticaly:CGFloat = 0) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - horizantaly, y: self.center.y - Verticaly ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + horizantaly, y: self.center.y + Verticaly ))
        self.layer.add(animation, forKey: "position")
    }
}//end of extension  UIButton


//animation like shake and customization for UITextfield
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

}//end of extension  UITextField

