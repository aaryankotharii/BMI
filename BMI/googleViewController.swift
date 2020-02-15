////
////  googleViewController.swift
////  BMI
////
////  Created by Aaryan Kothari on 14/02/20.
////  Copyright © 2020 Aaryan Kothari. All rights reserved.
////
//
//import UIKit
//import GoogleSignIn
//import Firebase
//
//
//class googleViewController: UIViewController, GIDSignInDelegate{
//
//
//    var idk = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    GIDSignIn.sharedInstance()?.presentingViewController = self
//    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
//    }
//
//    @IBAction func signInPressed(_ sender: Any) {
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signIn()
//    }
//
//
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        if let error = error {
//            print(error)
//            return
//        }
//
//
//        guard let authentication = user.authentication else { return }
//
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        print(credential as Any)
//
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let uid = user.userID else { return }
//            print("Sucessfully logged into firebase with Google!",uid)
//
//           //Access the storyboard and fetch an instance of the view controller
//            let storyboard = UIStoryboard(name: "Main", bundle: nil);
//            let vc = storyboard.instantiateViewController(withIdentifier: "chooseVC") as! chooseViewController
//           vc.firstName = user.profile.givenName
//           vc.lastName = user.profile.familyName
//                  let controller = storyboard.instantiateViewController(withIdentifier: "chooseViewController")
//        
//          self.present(controller, animated: true, completion: nil)
//        }
//    }
//}
//

