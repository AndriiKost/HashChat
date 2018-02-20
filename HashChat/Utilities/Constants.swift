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

// Colors
let hashPurplePlaceHolder = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0.5)

// Notification constance
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

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
