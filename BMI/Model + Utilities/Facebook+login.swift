//
//  Facebook+login.swift
//  BMI
//
//  Created by Aaryan Kothari on 15/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FacebookLogin
import FirebaseAuth


extension UIViewController
{
     func fbLogin(){
         
         let loginManager = LoginManager()
         loginManager.logIn(permissions: ["email"], from: self) { (result, error) in
           if error != nil {
             print("error")
             return
           }
           guard let token = AccessToken.current else {
             print("Failed to get access token")
             return
           }
             if self.getFBUserData() ==  true {
                 let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
               Auth.auth().signIn(with: credential) { (authResult, error) in
                 if let error = error {
                   print(error)
                   return
                 }
                 else{
                    print("Sucessfully logged into firebase with facebook!")
                    }
                }
            }
        }
     }
    
     func getFBUserData() -> Bool {
          
          if((AccessToken.current) != nil){
               
              GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                  if (error == nil){
                      

                     
                     let storyboard = UIStoryboard(name: "Main", bundle: nil);
                     let viewController =  storyboard.instantiateViewController(withIdentifier: "chooseVC") as! chooseViewController
                     let navController = UINavigationController(rootViewController: viewController)
                     navController.modalPresentationStyle = .fullScreen
                     self.present(navController, animated:true, completion: nil)
                     
                     let dict = result as! [String : AnyObject]
                     let picutreDic = dict as NSDictionary
                     viewController.firstName = picutreDic.object(forKey: "name") as! String
                     print("name FB :- ",viewController.firstName)

                  }
                  print(error?.localizedDescription as Any)
              })
             return true
          }
          return false
      }
}
