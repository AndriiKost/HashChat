//
//  AddChannelVC.swift
//  HashChat
//
//  Created by Andrii Kost on 2/23/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var channelDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func createChannelButtonPressed(_ sender: Any) {
        guard let channelName = nameTextField.text , nameTextField.text != "" else {return}
        guard let channelDescription = channelDescriptionTextField.text else {return}
        
        SocketService.instance.addChannel(name: channelName, description: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func closedModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        // add touch recognizer to the view, so user can dismiss the UIView by touching outside the xib
        backgroundView.addGestureRecognizer(closeTouch)
        
        // set placeholders name and color
        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : hashPurplePlaceHolder])
        
        channelDescriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : hashPurplePlaceHolder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
