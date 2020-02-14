//
//  googleViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 14/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase


class googleViewController: UIViewController{
    

    var idk = ""
    
    @IBOutlet weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
    

    @IBAction func signInPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    

}


