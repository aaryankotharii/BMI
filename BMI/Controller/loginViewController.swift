//
//  loginViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 11/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseAuth


class loginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        siginUser()
    }
    
    func siginUser(){
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email == "" || password == "" {
            self.showError(errorLabel, "Please fill in all fields")
    }
        else {
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if error != nil {
                switch error?.localizedDescription {
                case "The email address is badly formatted.":
                    self.showError(self.errorLabel,"Please enter a valid Email ID")
                case "The password is invalid or the user does not have a password.":
                    self.showError(self.errorLabel,"Incorrect Password")
                case "Too many unsuccessful login attempts. Please try again later.":
                    self.showError(self.errorLabel,"Too many unsuccessful login attempts. Please try again later")
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    self.showError(self.errorLabel,"User not Found, please SignUp")
                default:
                    self.authAlert(title: "Login failed",message: "Authentication failed please try again.")
                    }
            }
                else {
                    self.transitionToNextPage()
                }
        }
}
}
    
    func transitionToNextPage(){
        performSegue(withIdentifier: "tobmi", sender: self)
    }
    
}
