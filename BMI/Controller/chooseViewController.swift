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

    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavBar()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        print("signOut")
        let firebaseAuth = Auth.auth()
        do {
            // Set initial user default for login as false
            UserDefaults.standard.set(false, forKey: "login")
            try firebaseAuth.signOut()
            print("SignOut sucessful")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.present(vc!, animated: true, completion: nil)
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
