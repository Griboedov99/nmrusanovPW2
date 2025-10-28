//
//  RandomColors.swift
//  nmrusanovPW2
//
//  Created by Nick on 22.09.2025.
//

import UIKit

extension UIColor {
    
    /// Generates random hex
    /// - Returns: Seven character long String ("#RRGGBB")
    private static func randomHex() -> String {
        // Much simpler method than the one I used in PW1
        return String(format: "#%06X", Int.random(in: 0...0xFFFFFF))
    }
    
    /// Initializer from hex string
    /// - Parameter hex: "#RRGGBB" style String
    convenience init?(hex: String) {
        // Preparing our hex String
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        guard hexString.count == 6 else { return nil }
        
        var rgbValue: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&rgbValue) else { return nil }
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        // sRGB has wider color range
        self.init(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func toHexString() -> String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "000000"
        }
        
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        
        return String(format: "%02X%02X%02X", red, green, blue)
    }
    
    /// Generates an UIColor array with each color unique
    /// - Parameters:
    ///   - count: amount of colors in resulting array
    ///   - excludedColors: colors to exclude from resulting array
    /// - Returns: array of different colors
    static func getUniqueColors(
        count: Int,
        excluding excludedColors: [UIColor] = []
    ) -> [UIColor] {
        var colors: [UIColor] = []
        var usedHexCodes = Set<String>()
        
        while colors.count < count {
            let hex = randomHex()
            
            guard !usedHexCodes.contains(hex) else { continue }
            guard let color = UIColor(hex: hex) else { continue }
            guard !excludedColors.contains(where: { $0 == color }) else { continue }
            
            usedHexCodes.insert(hex)
            colors.append(color)
        }
        
        return colors
    }
}
