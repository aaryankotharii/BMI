//
//  loginViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 11/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase


class loginViewController: UIViewController {
    
    
    //MARK:- Outlets

    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    //MARK:- viewDidLoad + Initial Setup
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initialSetup()
        
        hideKeyboardWhenTappedAround()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        }
    
   
    
    func initialSetup(){
    googleButton.clipsToBounds = true

    facebookButton.clipsToBounds = true
             
    googleButton.layer.cornerRadius = 8
             
    facebookButton.layer.cornerRadius = 8
    
    errorLabel.alpha = 0
    
    loginButton.isEnabled = true
    }
    
    
    
    //LOGIN BUTTON
    @IBAction func login(_ sender: UIButton) {
        siginUser()
    }
    
    
    //MARK: - Signin methods
    func siginUser(){
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email == "" || password == "" {
            
            errorLabel.alpha = 1
            
            self.showError(errorLabel, "Please fill in all fields")
            
        } else {
            
            loginButton.isEnabled = false
            
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                
                if error != nil {
                    
                self.loginButton.isEnabled = true
                    
                self.errorLabel.alpha = 1
                    
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
                    
                } else {
                    
                        self.goToChooseViewController()
                    
                    }
              }
       }
}
    
    //MARK:- goto chooseViewController
    func goToChooseViewController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        let vc = storyboard.instantiateViewController(withIdentifier: "chooseVC") as! chooseViewController
        
        let navController = UINavigationController(rootViewController: vc)
        
        navController.modalPresentationStyle = .fullScreen
        
        self.present(navController, animated:true, completion: nil)
        }
    
    
    //MARK: - google Login
    @IBAction func google_signin(_ sender: Any) {
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().signIn()
        
        self.blurView()
        
    }
    
    
    
    //MARK: - facebook Login
    @IBAction func facebookLogin(_ sender: Any) {
        self.fbLogin()
        }
    
    
}
