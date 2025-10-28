//
//  WishMakerPresenter.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishMakerPresenter: WishMakerPresenterProtocol {
    weak var view: WishMakerViewProtocol?
    var interactor: WishMakerInteractorProtocol?
    var router: WishMakerRouterProtocol?
    
    private var currentInputMode: WishMakerViewController.InputMode = .sliders
    private var currentColor: ColorModel?
    
    func viewDidLoad() {
        let defaultColor = ColorModel(red: 0, green: 0.627, blue: 0.941, hex: "00A0F0")
        currentColor = defaultColor
        updateViewWithColor(defaultColor)
        updateButtonTitle()
    }
    
    func didChangeInputMode() {
        currentInputMode = interactor?.getNextInputMode(currentInputMode) ?? .sliders
        view?.updateUIForMode(currentInputMode)
        updateButtonTitle()
    }
    
    func didChangeColorViaSliders(red: Float, green: Float, blue: Float) {
        let colorModel = interactor?.processColorFromSliders(red: red, green: green, blue: blue)
        currentColor = colorModel
        if let colorModel = colorModel {
            updateViewWithColor(colorModel)
        }
    }
    
    func didChangeColorViaHex(hex: String) {
        guard interactor?.validateHex(hex) == true,
              let colorModel = interactor?.processColorFromHex(hex) else { return }
        
        currentColor = colorModel
        updateViewWithColor(colorModel)
    }
    
    func didChangeColorViaRGBHex(red: String, green: String, blue: String) {
        guard let colorModel = interactor?.processColorFromRGBHex(red: red, green: green, blue: blue) else { return }
        
        currentColor = colorModel
        updateViewWithColor(colorModel)
    }
    
    func didSelectColorFromPicker(_ color: UIColor) {
        // Конвертируем UIColor в ColorModel
        guard let components = color.cgColor.components, components.count >= 3 else { return }
        
        let colorModel = ColorModel(
            red: Float(components[0]),
            green: Float(components[1]),
            blue: Float(components[2]),
            hex: color.toHexString()
        )
        
        currentColor = colorModel
        updateViewWithColor(colorModel)
    }
    
    func didPressAddWishButton() {
        router?.navigateToWishList()
    }
    
    private func updateViewWithColor(_ colorModel: ColorModel) {
        view?.updateBackgroundColor(colorModel.uiColor)
        view?.updateHexFields(
            red: String(format: "%02X", Int(colorModel.red * 255)),
            green: String(format: "%02X", Int(colorModel.green * 255)),
            blue: String(format: "%02X", Int(colorModel.blue * 255)),
            fullHex: colorModel.hex
        )
        view?.updateSliders(red: colorModel.red, green: colorModel.green, blue: colorModel.blue)
    }
    
    private func updateButtonTitle() {
        let title: String
        switch currentInputMode {
        case .sliders: title = "Hex Input"
        case .hex: title = "Color Picker"
        case .picker: title = "Sliders"
        }
        view?.updateButtonTitle("Switch to \(title)")
    }
}
