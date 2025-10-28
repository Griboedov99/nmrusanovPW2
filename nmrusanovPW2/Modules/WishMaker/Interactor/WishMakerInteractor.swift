//
//  WishMakerInteractor.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishMakerInteractor: WishMakerInteractorProtocol {
    weak var presenter: WishMakerPresenterProtocol?
    
    func processColorFromSliders(red: Float, green: Float, blue: Float) -> ColorModel {
        let hex = String(
            format: "%02X%02X%02X",
            Int(red * 255),
            Int(green * 255),
            Int(blue * 255)
        )
        return ColorModel(red: red, green: green, blue: blue, hex: hex)
    }
    
    func processColorFromHex(_ hex: String) -> ColorModel? {
        let hexString = hex.hasPrefix("#") ? hex : "#\(hex)"
        guard let color = UIColor(hex: hexString),
              let components = color.cgColor.components,
              components.count >= 3 else { return nil }
        
        return ColorModel(
            red: Float(components[0]),
            green: Float(components[1]),
            blue: Float(components[2]),
            hex: hexString.replacingOccurrences(of: "#", with: "").uppercased()
        )
    }
    
    func processColorFromRGBHex(red: String, green: String, blue: String) -> ColorModel? {
        let hexString = "\(red)\(green)\(blue)"
        return processColorFromHex(hexString)
    }
    
    func validateHex(_ hex: String) -> Bool {
        let hexString = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        let hexRegex = "^[0-9A-Fa-f]{6}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", hexRegex)
        return predicate.evaluate(with: hexString)
    }
    
    func getNextInputMode(_ currentMode: WishMakerViewController.InputMode) -> WishMakerViewController.InputMode {
        switch currentMode {
        case .sliders: return .hex
        case .hex: return .picker
        case .picker: return .sliders
        }
    }
}
