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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables (default, if user doesn't pick one)
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var backColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // update UI
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            // if we haven't choose random color yet, set light gray for avatar
            if avatarName.contains("light") && backColor == nil {
                userImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBackColorPressed(_ sender: Any) {
        // Create a randomly generated UIColor
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        
        backColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        // set random color to avatar background color, so it can show in the ChannelVC
        avatarColor = "[\(red), \(green), \(blue), 1]"
        
        // Add animation when pressing the random color
        UIView.animate(withDuration: 0.2) {
            // Set image to random color
            self.userImage.backgroundColor = self.backColor
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        // Show the spinner and start animating
        spinner.isHidden = false
        spinner.startAnimating()
        
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
                                // Hide spinner and stop animation
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                // Unwind
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                // Post a notification that user created an account
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                    
                })
            }
        }
        
    }
    
    
    // Change the placeholder color and spinner
    func setupView() {
        // Hide spinner
        spinner.isHidden = true
        // set placeholders
        usernameLabel.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: hashPurplePlaceHolder])
        
        emailLabel.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: hashPurplePlaceHolder])
        
        passwordLabel.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: hashPurplePlaceHolder])
        
        // dismiss keyboard while user presing anywhere but not on the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignupVC.handleTap))
        // assign our tap to the view
        view.addGestureRecognizer(tap)
        
    }
    
    // If keyboard open, dismiss keyboard
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    
}
