//
//  Settings.swift
//  HasbroSTransformers
//
//  Created by Amir on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation

// for save and lode value by key over UserDefaults.standard
// to keep them even in case app completely closed
class DefaultsSettings {
    
    // save value by key over UserDefaults.standard permanet storage
    func saveSettings(keyName: String, keyValue: String){
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    // load value by key over UserDefaults.standard permanet storage
    func loadSettings(keyName: String) -> String {
        return UserDefaults.standard.string(forKey: keyName) ?? ""
    }
}
