//
//  chooseViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 12/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseAuth


class chooseViewController: UIViewController {

    //MARK: - Outlets + Variables
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var showDataButton: UIButton!
    
    lazy var firstName = ""
    lazy var lastName = ""
    
    
    
    //MARK:- ViewdidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if firstName != ""{
        greetingLabel.text = "Hey " + "\(firstName)" + ","
        }
        transparentNavBar()
        }
    
    
    //MARK: - Signout function
    @IBAction func signOutTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            // Set initial user default for login as false
            UserDefaults.standard.set(false, forKey: "login")
            try firebaseAuth.signOut()
            print("SignOut sucessful")
            back2Home()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    //MARK: - navigate to home
    func back2Home(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
