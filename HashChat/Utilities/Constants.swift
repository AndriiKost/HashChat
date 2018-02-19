//
//  Constants.swift
//  HashChat
//
//  Created by Andrii Kost on 2/17/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import Foundation

// Segues
let TO_LOGIN = "goToLoginVC"
let TO_SIGN_UP = "goToSignup"
let UNWIND = "unwinedToChannel"
let TO_AVATAR_PICKER = "goToAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// 
typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://hashchatty.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"


// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
