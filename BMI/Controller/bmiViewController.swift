//
//  bmiViewController.swift
//  BMI
//
//  Created by Aaryan Kothari on 12/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit


class bmiViewController: UIViewController {
    
    var name : String = ""
    var age : String = ""
    var height : String = ""
    var weight : String = ""
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    var bmi: BMI?

    
    @IBOutlet weak var bmiValueLabel: UILabel!
    
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("name is ",name)
        print("age is ",age)
        print("weight is ",weight)
        print("height is ",height)
        let Height = Float(height)!
        let Weight = Float(weight)!
        calculateBMI(height: Height,weight: Weight)
        print(bmi)
        bmiValue = getBMIValue()
        color = getColor()
        advice = getAdvice()
        
        bmiValueLabel.text = bmiValue
        view.backgroundColor = color
        adviceLabel.text = advice
        // Do any additional setup after loading the view.
    }
    
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
