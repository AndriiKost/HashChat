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
    
    // Transfer random color string into the UIColor    
    func returnUIColor(components: String) -> UIColor {
    //"avatarColor": "[0.592156862745098, 0.152941176470588, 0.23921568627451, 1]"
        
        // pass random generated color
        let scanner = Scanner(string: components)
        
        // set which characters to skip and not care about
        let skipped = CharacterSet(charactersIn: "[], ")
        
        // scan up to specific character (comma)
        let comma = CharacterSet(charactersIn: ",")
        
        // set the characters to be skipped
        scanner.charactersToBeSkipped = skipped
        
        // variables for red green blue and alpha
        var r, g, b, a : NSString?
        
        // scan string up to specific character and save into the r
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        // default color in case we fail with scanning and unwrapping
        let defaultColor = UIColor.lightGray
        
        // unwrap every variable
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        // Unwrap strings to doubles and set to CGFloat
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        // Set unwrapped CGFloat to our new color
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
    
    
}
