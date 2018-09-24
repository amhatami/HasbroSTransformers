//
//  API.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import Foundation

class API {
    
    let apiURL = "https://transformers-api.firebaseapp.com/transformers"
    let apiTokenURL = "https://transformers-api.firebaseapp.com/allspark"
    var apiToken : String = ""
    //    var apiToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MTXBqZF9wVXRNaVFFOE9xemVvIiwiaWF0IjoxNTM3NDI2MjMzfQ.zP8_8FBwPhBbnYNAZKUzv40b75MOlmgsFcOze-E_41M"
    
    //get one token in case of first time app loading
    func getOneToken() -> String {
        
        let parameters : [String : Any] = [:]
        let semaphore = DispatchSemaphore(value: 0)
        var dataString : String = ""
        
        //create the url with URL
        let url = URL(string: apiTokenURL )!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        //create Header using the session object to send data to the server
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            dataString = String(data: data, encoding: .utf8)!
            semaphore.signal()
            
        })
        task.resume()
        semaphore.wait()
        return dataString
    }
    
    func getTransformers() -> [Transformer] {
        
        var tranformersMain : TransformerList?
        let parameters : [String : Any] = [:]
        let semaphore = DispatchSemaphore(value: 0)
        
        //create the url with URL
        let url = URL(string: apiURL )!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(apiToken, forHTTPHeaderField: "Authorization")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                tranformersMain = try decoder.decode(TransformerList.self, from: data)
                semaphore.signal()
            } catch {
                print(error)
            }
        })
        task.resume()
        semaphore.wait()
        
        return(tranformersMain?.transformers)!
    }
    
    
    func postTransformer(transformer : Transformer) -> Transformer {
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        var transformerOut : Transformer!
        let semaphore = DispatchSemaphore(value: 0)
        //create the url with URL
        let url = URL(string: apiURL )!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: transformer.toJson(), options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

