//
//  Blur+functions.swift
//  BMI
//
//  Created by Aaryan Kothari on 15/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func blurView(){
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

    func removeBlurView(){
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
}
