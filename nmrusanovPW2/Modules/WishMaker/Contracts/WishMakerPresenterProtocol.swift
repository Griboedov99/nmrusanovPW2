//
//  WishMakerPresenterProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishMakerPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didChangeInputMode()
    func didChangeColorViaSliders(red: Float, green: Float, blue: Float)
    func didChangeColorViaHex(hex: String)
    func didChangeColorViaRGBHex(red: String, green: String, blue: String)
    func didSelectColorFromPicker(_ color: UIColor)
    func didPressAddWishButton()
}
