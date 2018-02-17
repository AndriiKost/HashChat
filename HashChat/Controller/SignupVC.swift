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

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

}
