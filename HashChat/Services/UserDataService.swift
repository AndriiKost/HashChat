//
//  UserDataService.swift
//  HashChat
//
//  Created by Andrii Kost on 2/19/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    // create public variable (other classes can read, but can't set it)
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    // set the variables
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    
    // 
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    
}
