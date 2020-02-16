//
//  Alert+Functions.swift
//  BMI
//
//  Created by Aaryan Kothari on 11/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    
    //MARK: - ALERT function for Authentication
    internal func authAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Return", style: .default) { (UIAlertAction) in
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        }
    
    
    //MARK: - Error Function for Authentication
    internal func showError(_ errorLabel: UILabel ,_ message: String){
        errorLabel.alpha = 1
        errorLabel.text = message
        errorLabel.numberOfLines = 5
        }
    
    
    //MARK:- Dissmiss keyboard on tap
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        }
    
    
    @objc func dismissKeyboard() {   view.endEditing(true) }
    
    
    //MARK: - Make the navigation bar background clear
    func transparentNavBar(){
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    }
}
