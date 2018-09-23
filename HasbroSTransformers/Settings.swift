//
//  Settings.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation

class Settings {
    func saveSettings(keyName: String, keyValue: String){
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    func loadSettings(keyName: String) -> String {
        return UserDefaults.standard.string(forKey: keyName) ?? ""
    }
}
