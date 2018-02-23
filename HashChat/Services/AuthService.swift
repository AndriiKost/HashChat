//
//  AuthService.swift
//  HashChat
//
//  Created by Andrii Kost on 2/19/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    // saving email inside the app (no passwords, not secure)
    let defaults = UserDefaults.standard
    
    // Do checks on how we want UI to display ( if not logged in, show login button)
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    //MARK: - Register user func
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        //complition handler
        let lowerCaseEmail = email.lowercased()
        
        // body for request
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //Sending request with alamofire to register the user
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                // letting any of the locations that called this functhion know that it failed
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler ) {
        
        //complition handler
        let lowerCaseEmail = email.lowercased()
        
        // body for request
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //Sending request with alamofire to login user
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                //Parsing Using SwiftyJSON
                guard let data = response.data else { return }
                do {
                let json = try JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                } catch {
                    debugPrint(error)
                }
                
                self.isLoggedIn = true
                completion(true)
                
            } else {
                // letting any of the locations that called this functhion know that it failed
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        // body for request
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        // Web Request
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                
                self.setUserInfo(data: data)
                
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
     
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func setUserInfo(data: Data) {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
            
        } catch {
            debugPrint(error)
        }
    }
    
}
