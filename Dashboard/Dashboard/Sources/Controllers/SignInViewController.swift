//
//  LoginViewController.swift
//  Dashboard
//
//  Created by Remi Poulenard on 27/11/2020.
//

import UIKit
import OAuthSwift
import SafariServices

class SignInViewController: UIViewController {
    @IBOutlet var LoginButton: UIButton!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    var userRequests = UserRequest()
    var serviceRequests = ServiceRequest()
    var userSignIn: UserModel?
    var userServices: [ServiceModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userSignIn = nil
        self.PasswordField.textContentType = .oneTimeCode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.UsernameField.text = ""
        self.PasswordField.text = ""
    }
    
    func presentSignInAlert(message: String) {
        let errorView = UIAlertController(title: "Cannot login with this account", message: message, preferredStyle: .alert)
        errorView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(errorView, animated: true, completion: nil)
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        if let unpackedUserName = UsernameField.text, let unpackedPassword = PasswordField.text {
            if unpackedUserName != "" && unpackedUserName != "" {
                self.userRequests.signInRequest(Username: unpackedUserName, Password: unpackedPassword, completionHandler: { (result) in
                    switch result {
                        case .success(let apiResponse):
                            print("Succesfully SignIn: \(apiResponse.username) with id: \(apiResponse.userId)")
                            self.userSignIn = apiResponse
                            self.requestUserServices()
                        case .failure(let errorResponse):
                            print("[ERROR] => \(errorResponse.localizedDescription.debugDescription)")
                            self.presentSignInAlert(message: errorResponse.localizedDescription)
                    }
                })
            }
        }
    }
    
    func requestUserServices() {
        if let unpackedUserId = self.userSignIn?.userId {
            self.serviceRequests.getUserServicesByGuid(guid: unpackedUserId) { (apiResult) in
                switch apiResult {
                    case .success(let userServicesModel):
                        self.userServices = userServicesModel
                        self.performSegue(withIdentifier: "GoToHome", sender: self)
                    case .failure(let error):
                        print("[ERROR] => \(error.localizedDescription.debugDescription)")
                }
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToSignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToHome" {
            if let homeVC = segue.destination as? HomeViewController {
                homeVC.userModel = self.userSignIn
                if let unpackedUserServices = self.userServices {
                    for service in unpackedUserServices {
                            homeVC.currentUserServices.append((service, nil))
                    }
                }
            }
        }
    }
}
