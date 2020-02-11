//
//  showViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 12/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class showViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userinfo = [String: String]()
    var user = [UserInfo]()
    var names : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate  = self
        tableView.dataSource = self
        
            print("got Password")
            //let uid = Auth.auth().currentUser?.uid
            let db = Firestore.firestore()
        
            db.collection("users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let name = document.data()["name"] as? String {
                            print(name)
                            self.names.append(name)
                        }
                        let age = document.data()["age"] as? String
                        let weight = document.data()["weight"] as? String
                        let height = document.data()["height"] as? String
                        print(document.data()["name"].debugDescription)
                        
//                            self.lastName = document.data()["lastName"] as? String
//                            self.nameLabel.alpha=1
//                            self.nameLabel.text = self.firstName + "  " + self.lastName
//                            print(self.firstName ?? "","first Name")
                    }
                }
                self.tableView.reloadData()
            }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? showTableViewCell
        cell?.userName.text = names[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
