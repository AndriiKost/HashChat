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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func generateBackColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        // Safe unwrap optional label and checking if text inside the label doesn't equal empty string, create a variable
        guard let email = emailLabel.text , emailLabel.text != "" else {return}
        
        guard let pass = passwordLabel.text , passwordLabel.text != "" else {return}
        
        // Signing up proccess
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        print("LogedIn User!", AuthService.instance.authToken)
                    }
                    
                })
            }
        }
        
    }
    
    
    
    
    
}
