//
//  bmiViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 12/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.



//MARK:- BMI functions + colors + advice taken from Angela YU app BMI calculator
import UIKit

class bmiViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    //MARK: - Variables
    var name : String = ""
    var age : String = ""
    var height : String = ""
    var weight : String = ""
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    var bmi: BMI?
    
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
    transparentNavBar()
    getValues()
    }
    
    //MARK: - Set Values
    func getValues(){
        //Get values based on data
        calculateBMI(height: Float(height)!,weight: Float(weight)!)
        
        // assign respective values to respective variables
        bmiValue = getBMIValue()
        color = getColor()
        advice = getAdvice()
        
        // assign variable values to outlets
        bmiValueLabel.text = bmiValue
       // adviceLabel.text = advice
        view.backgroundColor = color
        
        nameLabel.text = "Name is  " + name
        heightLabel.text = "Height " + height
        weightLabel.text =  "Weight = " + weight
        ageLabel.text = "Age is " + age
    }
    
    
    //MARK:- Get Values
    func getBMIValue() -> String {
        
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        
        return bmiTo1DecimalPlace
        }
    
    func getAdvice() -> String {
        
        return bmi?.advice ?? "No advice"
        }
    
    func getColor() -> UIColor {
        
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    
    //MARK:- yo
    func calculateBMI(height: Float, weight: Float) {
        
         let bmiValue = (weight / (height * height)) * 10000
        
         if bmiValue < 18.5 {
             bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
            
         } else if bmiValue < 24.9 {
             bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
            
         } else {
             bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
         }
     }
}
