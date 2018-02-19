//
//  SignupVC.swift
//  HashChat
//
//  Created by Andrii Kost on 2/17/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    // Variables (default, if user doesn't pick one)
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBackColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        // Safe unwrap optional label and checking if text inside the label doesn't equal empty string, create a variable
        guard let email = emailLabel.text , emailLabel.text != "" else {return}
        
        guard let name = usernameLabel.text , usernameLabel.text != "" else {return}
        
        guard let pass = passwordLabel.text , passwordLabel.text != "" else {return}
        
        // First phase - register the user
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                // Second phase - login in the user
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        // Third phase - create the user
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                    
                })
            }
        }
        
    }
    
    
    
    
    
}
