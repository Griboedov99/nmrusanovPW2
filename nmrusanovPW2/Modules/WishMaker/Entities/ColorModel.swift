//
//  ColorModel.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

struct ColorModel {
    let red: Float
    let green: Float
    let blue: Float
    let hex: String
    
    var uiColor: UIColor {
        return UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: 1.0
        )
    }
}
