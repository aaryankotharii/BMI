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
    

    //MARK:- Outlets + Variables
    @IBOutlet weak var tableView: UITableView!
    
    var userinfo = [String: String]()
    var user =  [[String:String]]()
    var names : [String] = []
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate  = self
        
        tableView.dataSource = self
        
        getData()
        
        }
    
    //MARK: - Get Data From FireBase
    func getData(){
        
        let db = Firestore.firestore()
        
            db.collection("users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        
                        if let name = document.data()["name"] as? String {
                            
                            if let age = document.data()["age"] as? String {
                                
                                if let weight = document.data()["weight"] as? String {
                                    
                                    if let height = document.data()["height"] as? String {
                                        
                                        if let gender = document.data()["gender"] as? Int {
                                            
                                            self.userinfo = ["name":name,"age":age,"weight":weight,"height":height,"gender":"\(gender)"]
                                            
                                                self.user.append(self.userinfo)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                self.tableView.reloadData()
                    }
                }
    
    
    //MARK: - tableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? showTableViewCell
        
        cell?.userName.text = user[indexPath.row]["name"]
        
        let sex = user[indexPath.row]["gender"]
        
        switch sex {
            
        case "0":
            cell?.userImage.image = UIImage(named: "m")
            
        case "1":
            cell?.userImage.image = UIImage(named: "f")
            
        default:
            cell?.userImage.image = .none
        }
        
        return cell!
        }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //unhighlight cell
        tableView.deselectRow(at: indexPath, animated: true)
        
        //perform segue
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "bmiViewController") as? bmiViewController

        let data = user[indexPath.row]
        
        vc?.name = data["name"] ?? ""
        
        vc?.age = data["age"] ?? ""

        vc?.weight = data["weight"] ?? ""
        
        vc?.height = data["height"] ?? ""

        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
