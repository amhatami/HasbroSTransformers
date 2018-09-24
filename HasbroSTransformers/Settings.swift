//
//  Settings.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation

class DefaultsSettings {
    
    let apiToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MTXBqZF9wVXRNaVFFOE9xemVvIiwiaWF0IjoxNTM3NDI2MjMzfQ.zP8_8FBwPhBbnYNAZKUzv40b75MOlmgsFcOze-E_41M"
    
    let apiToken02 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MTjhISzMtSi11aWtjR0xzLVRXIiwiaWF0IjoxNTM3NzU0MDkxfQ.tIOje9UtpIYmEUUPC65U-B8meEiw1SPIO8860t1amYk"
    
    func saveSettings(keyName: String, keyValue: String){
        UserDefaults.standard.set(keyValue, forKey: keyName)
    }
    
    func loadSettings(keyName: String) -> String {
        return UserDefaults.standard.string(forKey: keyName) ?? ""
    }
}
