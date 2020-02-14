//
//  signupViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 11/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class signupViewController: UIViewController {

    //Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    //Variables
     let passwordConstraints : String =  "Password should be minimum 8 characters, should contain atleast one uppercase letter, one lowercase letter, atleast one number digit and at least one special character"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        initialSetup()
        hideKeyboardWhenTappedAround()
        }
    
    func initialSetup(){
        Utilities.styleFilledButton(signupButton)
        signupButton.backgroundColor =  #colorLiteral(red: 0.4722413421, green: 0.8389235139, blue: 1, alpha: 1)
        signupButton.isEnabled = true
        errorLabel.alpha = 0
    }
    
    func fieldCheck() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        { return "Please Fill in all the fields" }
        return nil
    }
    
    func emailIsValid(_ email: String) -> Bool
        {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        }
    
    func validateEmail() -> String?
        {
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if emailIsValid(cleanedEmail) == false { return "Please Enter a Valid email ID" }
        return nil
       }
    
    func passwordIsValid(_ password : String) -> Bool? {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
        }
    
    func validatePassword() -> String? {
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if passwordIsValid(cleanedPassword) == false  {  return passwordConstraints  }
        return nil
    }
    
    func errorCheck() -> String?{
        if fieldCheck() != nil {
        return fieldCheck()
        }
        else if validateEmail() != nil {
            return validateEmail()
        }
        else if validatePassword() != nil {
            return validatePassword()
        }
        return nil
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        if errorCheck() != nil{
            errorLabel.alpha = 1
            self.showError(errorLabel,errorCheck()!)
        }
        else {
            signupButton.isEnabled = false
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    let errorMessage = error?.localizedDescription
                    if errorMessage == "The email address is already in use by another account." {
                       self.authAlert(title: "Account Exists", message: "Account already exists please login")
                   }
                    else { self.authAlert(title: "Error", message: errorMessage ?? "please try again")}
                }
                
                    //MARK: - adding data on firebase
                    /*  else {
                    let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data:
                    ["firstName":firstName,"lastName":lastName,"email":email,"uid":result!.user.uid,"age":0]) { (error) in
                    if error != nil {
                    print("Error saving user info")
                    }
                    }
                    self.authAlert(title: "Success", message: "you can now login!")
                    }*/
                self.authAlert(title: "Success", message: "you can now login!")
            }
        }
    }
}
