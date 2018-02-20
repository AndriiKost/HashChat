//
//  ProfileVC.swift
//  HashChat
//
//  Created by Andrii Kost on 2/20/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closeMoadlPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        
        if UserDataService.instance.avatarName == "" {
            profileImage.image = UIImage(named: "profileDefault")
        } else {
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        }
        username.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        
        // dismiss by tapping
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        // add recognizer
        backView.addGestureRecognizer(closeTouch)
}
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
