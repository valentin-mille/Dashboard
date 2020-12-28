//
//  SignUpViewController.swift
//  Dashboard
//
//  Created by Remi Poulenard on 28/11/2020.
//

import UIKit
import OAuthSwift
import SafariServices

class SignUpViewController: UIViewController {
    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var UsernameField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    var userRequests: UserRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userRequests = UserRequest()
        self.PasswordField.textContentType = .oneTimeCode
    }
    
    @IBAction func RegisterAction(_ sender: UIButton) {
        if let unpackedUserName = UsernameField.text, let unpackedPassword = PasswordField.text {
            if unpackedUserName != "" && unpackedUserName != "" {
                self.userRequests?.signUpRequest(Username: unpackedUserName, Password: unpackedPassword, completionHandler: { (result) in
                    switch result {
                        case .success(_):
                            self.dismiss(animated: true, completion: nil)
                        case .failure(let errorResponse):
                            print("[ERROR] => \(errorResponse.localizedDescription.debugDescription)")
                            return
                    }
                })
            }
        }
    }
    
}
