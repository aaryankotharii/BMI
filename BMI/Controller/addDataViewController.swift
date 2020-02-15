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


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weigthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var ageOrWeight = Bool()
    
    var gender : Int = 0
    var ageArray : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
    
    var weightArray = [30, 30.5, 31, 31.5, 32, 32.5, 33, 33.5, 34, 34.5, 35, 35.5, 36, 36.5, 37, 37.5, 38, 38.5, 39, 39.5, 40, 40.5, 41, 41.5, 42, 42.5, 43, 43.5, 44, 44.5, 45, 45.5, 46, 46.5, 47, 47.5, 48, 48.5, 49, 49.5, 50, 50.5, 51, 51.5, 52, 52.5, 53, 53.5, 54, 54.5, 55, 55.5, 56, 56.5, 57, 57.5, 58, 58.5, 59, 59.5, 60, 60.5, 61, 61.5, 62, 62.5, 63, 63.5, 64, 64.5, 65, 65.5, 66, 66.5, 67, 67.5, 68, 68.5, 69, 69.5, 70, 70.5, 71, 71.5, 72, 72.5, 73, 73.5, 74, 74.5, 75, 75.5, 76, 76.5, 77, 77.5, 78, 78.5, 79, 79.5, 80, 80.5, 81, 81.5, 82, 82.5, 83, 83.5, 84, 84.5, 85, 85.5, 86, 86.5, 87, 87.5, 88, 88.5, 89, 89.5, 90, 90.5, 91, 91.5, 92, 92.5, 93, 93.5, 94, 94.5, 95, 95.5, 96, 96.5, 97, 97.5, 98, 98.5, 99, 99.5, 100, 100.5, 101, 101.5, 102, 102.5, 103, 103.5, 104, 104.5, 105, 105.5, 106, 106.5, 107, 107.5, 108, 108.5, 109, 109.5, 110, 110.5, 111, 111.5, 112, 112.5, 113, 113.5, 114, 114.5, 115, 115.5, 116, 116.5, 117, 117.5, 118, 118.5, 119, 119.5, 120, 120.5, 121, 121.5, 122, 122.5, 123, 123.5, 124, 124.5, 125, 125.5, 126, 126.5, 127, 127.5, 128, 128.5, 129, 129.5, 130, 130.5, 131, 131.5, 132, 132.5, 133, 133.5, 134, 134.5, 135, 135.5, 136, 136.5, 137, 137.5, 138, 138.5, 139, 139.5, 140, 140.5, 141, 141.5, 142, 142.5, 143, 143.5, 144, 144.5, 145, 145.5, 146, 146.5, 147, 147.5, 148, 148.5, 149, 149.5, 150, 150.5, 151, 151.5, 152, 152.5, 153, 153.5, 154, 154.5, 155, 155.5, 156, 156.5, 157, 157.5, 158, 158.5, 159, 159.5, 160, 160.5, 161, 161.5, 162, 162.5, 163, 163.5, 164, 164.5, 165, 165.5, 166, 166.5, 167, 167.5, 168, 168.5, 169, 169.5, 170, 170.5, 171, 171.5, 172, 172.5, 173, 173.5, 174, 174.5, 175, 175.5, 176, 176.5, 177, 177.5, 178, 178.5, 179, 179.5, 180, 180.5, 181, 181.5, 182, 182.5, 183, 183.5, 184, 184.5, 185, 185.5, 186, 186.5, 187, 187.5, 188, 188.5, 189, 189.5, 190, 190.5, 191, 191.5, 192, 192.5, 193, 193.5, 194, 194.5, 195, 195.5, 196, 196.5, 197, 197.5, 198, 198.5, 199, 199.5, 200]
    
    var heightArray = [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249]
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        errorLabel.alpha = 0
        super.viewDidLoad()
    }
    
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
    
    
    @IBAction func ageTypingStarted(_ sender: UITextField) {
        ageOrWeight = true
        pickerView.isHidden = false
        pickerView.reloadComponent(0)
    }
    
    @IBAction func weightTypingStarted(_ sender: UITextField) {
        ageOrWeight = false
        pickerView.isHidden = false
        pickerView.reloadComponent(0)
    }
    
    @IBAction func addData(_ sender: UIButton) {
        if validateFields() != nil {
            errorLabel.alpha = 1
            self.showError(errorLabel, validateFields() ?? "error!")
        }
        else {
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
                   // self.authAlert(title: "Success", message: "your data has been successfully saved!")
                    let alert = UIAlertController(title: "Success", message: "your data has been successfully saved!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Return", style: .default) { (UIAlertAction) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
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
        
            if component == 0 {
                ageTextField.text =  "\(ageArray[row])"
            }
            else if component == 1{
                weigthTextField.text =  "\(weightArray[row])"
            }
        if component == 2 {
        heightTextField.text =  "\(heightArray[row])"
        }
        }
}
    

