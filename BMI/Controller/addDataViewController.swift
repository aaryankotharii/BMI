//
//  addDataViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 12/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class addDataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{


    //MARK: - OUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weigthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addButton: UIButton!
    //MARK: - Variables
    var ageOrWeight = Bool()
    var gender : Int = 0
    var ageArray = [Int]()
    var weightArray = [Double]()
    var heightArray = [Int]()
    
    //MARK: - ViewDidLoad + initial setup
    override func viewDidLoad() {
        setArrayValues()
        hideKeyboardWhenTappedAround()
        errorLabel.alpha = 0
        super.viewDidLoad()
    }
    
    func setArrayValues(){
        
    let s1 = stride(from:  1, to: 100, by: 1  )
    
    let s2 = stride(from: 30, to: 200, by: 0.5)

    let s3 = stride(from: 40, to: 250, by: 1  )

    for i in s1 {    ageArray.append(i)       }

    for i in s2 {    weightArray.append(i)    }

    for i in s3 {    heightArray.append(i)    }
    }
    
    
    //MARK: - validate Fields
    func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        weigthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            heightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all the fields"
        }
        return nil
    }
    
    
    
    //MARK: - add data to firebase
    @IBAction func addData(_ sender: UIButton) {
        //valudate fields
        if validateFields() != nil {
            errorLabel.alpha = 1
            self.showError(errorLabel, validateFields() ?? "error!")
        }
        else {
            addButton.isEnabled = false
            //Data variables
            let name =  nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let age = ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let weigth = weigthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let height = heightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let uid = Auth.auth().currentUser?.uid
            let gender = segment.selectedSegmentIndex
            let db = Firestore.firestore()
            
            
            db.collection("users").addDocument(data: ["name":name!,"age":age!,"weight":weigth!,"height":height!,"uid":uid!,"gender":gender]) { (error) in
                
                if error != nil {
                    print("Error saving user info")
                }
                else {
                    self.successAlert()
                }
            }
        }
    }
    
    
    //MARK: - success alert
    func successAlert(){
        let alert = UIAlertController(title: "Success", message: "your data has been successfully saved!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Return", style: .default) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)}
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0{
            return ageArray.count
        }
            
        else if component == 1 {
            return weightArray.count
        }
        
        return heightArray.count
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
        return "\(ageArray[row])"
        }
            
        else if component == 1{
            return "\(weightArray[row])"
        }
        
        return "\(heightArray[row])"
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0
        {
            ageTextField.text =  "\(ageArray[row])"
        }
            
        else if component == 1
        {
            weigthTextField.text =  "\(weightArray[row])"
        }
        
        if component == 2
        {
            heightTextField.text =  "\(heightArray[row])"
        }
        
        }
    
}
    

