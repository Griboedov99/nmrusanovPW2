//
//  WishMakerViewProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishMakerViewProtocol: AnyObject {
    var presenter: WishMakerPresenterProtocol? { get set }
    
    func updateBackgroundColor(_ color: UIColor)
    func updateHexFields(red: String, green: String, blue: String, fullHex: String)
    func updateSliders(red: Float, green: Float, blue: Float)
    func updateUIForMode(_ mode: WishMakerViewController.InputMode)
    func updateButtonTitle(_ title: String)
}
