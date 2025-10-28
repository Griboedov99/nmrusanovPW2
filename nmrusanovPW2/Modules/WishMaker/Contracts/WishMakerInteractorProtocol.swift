//
//  WishMakerInteractorProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//


protocol WishMakerInteractorProtocol: AnyObject {
    var presenter: WishMakerPresenterProtocol? { get set }
    
    func processColorFromSliders(red: Float, green: Float, blue: Float) -> ColorModel
    func processColorFromHex(_ hex: String) -> ColorModel?
    func processColorFromRGBHex(red: String, green: String, blue: String) -> ColorModel?
    func validateHex(_ hex: String) -> Bool
    func getNextInputMode(_ currentMode: WishMakerViewController.InputMode) -> WishMakerViewController.InputMode
}
