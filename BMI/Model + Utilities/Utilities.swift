//
//  Utilities.swift
//  BMI
//
//  Created by Aaryan Kothari on 16/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//
import UIKit

class Utilities{
    
    
static func styleTextField(_ textfield:UITextField) {

    // Create the bottom line
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
    bottomLine.backgroundColor = UIColor.init(red: 215/255, green: 106/255, blue: 138/255, alpha: 1).cgColor
    textfield.borderStyle = .none
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
     }
    
    
static func styleFilledButton(_ button:UIButton) {
    // Filled rounded corner style
    button.backgroundColor = UIColor.white
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.white
}

static func styleHollowButton(_ button:UIButton) {
    // Hollow rounded corner style
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.white
}
}

