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


    @IBOutlet weak var greetingLabel: UILabel!
    
    lazy var firstName = ""
    lazy var lastName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(firstName,lastName)
        transparentNavBar()
        greetingLabel.text = "Hey " + "\(firstName)" + ","
        print("yo")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    
    @IBAction func signOutTapped(_ sender: Any) {
        print("signOut")
        let firebaseAuth = Auth.auth()
        do {
            // Set initial user default for login as false
            UserDefaults.standard.set(false, forKey: "login")
            try firebaseAuth.signOut()
            print("SignOut sucessful")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(vc, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
