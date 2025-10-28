//
//  WishMakerViewController.swift
//  nmrusanovPW2
//
//  Created by Nick on 22.09.2025.
//
import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: - Input Mode
    enum InputMode {
        case sliders
        case hex
        case picker
    }
    
    // MARK: - VIPER
    var presenter: WishMakerPresenterProtocol?
    
    // MARK: - UI Elements
    internal var titleView: UILabel!
    internal var sliderRed: CustomSlider!
    internal var sliderGreen: CustomSlider!
    internal var sliderBlue: CustomSlider!
    internal var sliderStack: UIStackView!
    internal var hexStack: UIStackView!
    internal var pickerStack: UIStackView!
    internal var switchButton: UIButton!
    internal var currentInputMode: InputMode = .sliders
    
    // Hex input fields
    internal var hexTitleLabel: UILabel!
    internal var hexTextField: UITextField!
    internal var rgbHexStack: UIStackView!
    internal var redHexField: UITextField!
    internal var greenHexField: UITextField!
    internal var blueHexField: UITextField!
    internal var addWishButton: UIButton!
    
    // Color picker
    internal var pickerTitleLabel: UILabel!
    internal var pickerButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
        setupAccessibility()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Constants.Colors.defaultBackground
        configureTitle(title: Constants.WishMaker.appName, makeRainbow: Constants.WishMaker.makeRainbowHeader)
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configureSwitchButton()
        configureHexInput()
        configureColorPicker()
        updateUI()
    }
    
    private func randomizeStringColors(attributedString: inout NSMutableAttributedString) {
        let ln = attributedString.string.count
        let colors = UIColor.getUniqueColors(count: ln, excluding: [Constants.Colors.defaultBackground])
        
        for i in 0..<ln {
            let color = colors[i]
            attributedString.addAttribute(
                .foregroundColor,
                value: color,
                range: NSRange(location: i, length: 1)
            )
        }
    }
    
    private func configureTitle(title: String, makeRainbow: Bool = false) {
        titleView = UILabel()
        var attributedString = NSMutableAttributedString(string: title)
        if makeRainbow {
            randomizeStringColors(attributedString: &attributedString)
        }
        
        attributedString.addAttribute(
            .font,
            value: UIFont.boldSystemFont(ofSize: Constants.FontSizes.largeTitle),
            range: NSRange(location: 0, length: title.count)
        )
        
        titleView.attributedText = attributedString
        view.addSubview(titleView)
        
        titleView.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.Common.defaultSpace)
    }
    
    private func configureDescription(){
        let descriptionView = UILabel()
        descriptionView.text = Constants.WishMaker.appDescription
        descriptionView.font = UIFont.systemFont(ofSize: Constants.FontSizes.body)
        descriptionView.textColor = Constants.Colors.white
        descriptionView.numberOfLines = 0
        descriptionView.textAlignment = .left
        
        view.addSubview(descriptionView)
        
        descriptionView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.Common.defaultSpace)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.Common.defaultSpace)
        descriptionView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Constants.Common.defaultSpace)
    }
    
    private func configureAddWishButton() {
        addWishButton = UIButton()
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.WishMaker.buttonHeight)
        addWishButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.WishMaker.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.Common.defaultSpace)
        
        addWishButton.backgroundColor = Constants.Colors.white
        addWishButton.setTitleColor(Constants.Colors.secondary, for: .normal)
        addWishButton.setTitle(Constants.WishMaker.wishButtonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.Common.cornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureSliders() {
        sliderStack = UIStackView()
        sliderStack.axis = .vertical
        view.addSubview(sliderStack)
        sliderStack.layer.cornerRadius = Constants.Common.cornerRadiusLarge
        sliderStack.clipsToBounds = true
        
        sliderRed = CustomSlider(
            title: Constants.WishMaker.redTitle,
            min: Constants.WishMaker.sliderMin,
            max: Constants.WishMaker.sliderMax
        )
        sliderGreen = CustomSlider(
            title: Constants.WishMaker.greenTitle,
            min: Constants.WishMaker.sliderMin,
            max: Constants.WishMaker.sliderMax
        )
        sliderBlue = CustomSlider(
            title: Constants.WishMaker.blueTitle,
            min: Constants.WishMaker.sliderMin,
            max: Constants.WishMaker.sliderMax
        )
        
        configureSliderHandlers()
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            sliderStack.addArrangedSubview(slider!)
        }
        
        sliderStack.pinCenterX(to: view)
        sliderStack.pinHorizontal(to: view, Constants.WishMaker.stackLeading)
        sliderStack.pinBottom(to: addWishButton.topAnchor, Constants.Common.defaultSpace)
    }
    
    private func configureSliderHandlers() {
        sliderRed.valueChanged = { [weak self] value in
            self?.handleSliderColorChange()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.handleSliderColorChange()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.handleSliderColorChange()
        }
    }
    
    private func configureSwitchButton() {
        switchButton = UIButton(type: .system)
        switchButton.backgroundColor = Constants.Colors.white
        switchButton.setTitleColor(Constants.Colors.primary, for: .normal)
        switchButton.layer.cornerRadius = Constants.Common.cornerRadius
        switchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.FontSizes.body)
        switchButton.setHeight(Constants.WishMaker.buttonHeight)
        
        switchButton.addTarget(self, action: #selector(switchInputMode), for: .touchUpInside)
        
        view.addSubview(switchButton)
        
        switchButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Constants.Common.defaultSpace)
        switchButton.pinBottom(to: sliderStack.topAnchor, Constants.WishMaker.stackBottom)
        
        updateButtonTitle()
    }
    
    private func configureHexInput() {
        hexStack = UIStackView()
        hexStack.axis = .vertical
        hexStack.spacing = Constants.WishMaker.stackSpacing
        view.addSubview(hexStack)
        hexStack.layer.cornerRadius = Constants.Common.cornerRadiusLarge
        hexStack.clipsToBounds = true
        hexStack.layoutMargins = UIEdgeInsets(
            top: Constants.WishMaker.stackPadding,
            left: Constants.WishMaker.stackPadding,
            bottom: Constants.WishMaker.stackPadding,
            right: Constants.WishMaker.stackPadding
        )
        hexStack.isLayoutMarginsRelativeArrangement = true
        
        hexTitleLabel = UILabel()
        hexTitleLabel.text = Constants.WishMaker.hexTitle
        hexTitleLabel.font = UIFont.boldSystemFont(ofSize: Constants.FontSizes.body)
        hexTitleLabel.textColor = Constants.Colors.white
        hexTitleLabel.textAlignment = .center
        
        hexTextField = UITextField()
        hexTextField.placeholder = "\(Constants.WishMaker.hexPrefix)RRGGBB"
        hexTextField.borderStyle = .roundedRect
        hexTextField.backgroundColor = Constants.Colors.white
        hexTextField.textAlignment = .center
        hexTextField.keyboardType = .asciiCapable
        hexTextField.autocapitalizationType = .allCharacters
        hexTextField.setHeight(Constants.WishMaker.textFieldHeight)
        
        rgbHexStack = UIStackView()
        rgbHexStack.axis = .horizontal
        rgbHexStack.spacing = Constants.WishMaker.stackSpacing / 2
        rgbHexStack.distribution = .fillEqually
        
        redHexField = createHexTextField(placeholder: "RR")
        greenHexField = createHexTextField(placeholder: "GG")
        blueHexField = createHexTextField(placeholder: "BB")
        
        for field in [redHexField, greenHexField, blueHexField] {
            rgbHexStack.addArrangedSubview(field!)
        }
        
        hexStack.addArrangedSubview(hexTitleLabel)
        hexStack.addArrangedSubview(hexTextField)
        hexStack.addArrangedSubview(rgbHexStack)
        
        hexStack.pinCenterX(to: view)
        hexStack.pinHorizontal(to: view, Constants.WishMaker.stackLeading)
        hexStack.pinTop(to: switchButton.topAnchor, Constants.Common.defaultSpace)
        
        configureHexHandlers()
    }
    
    private func configureHexHandlers() {
        hexTextField.addTarget(self, action: #selector(handleHexColorChange), for: .editingChanged)
        redHexField.addTarget(self, action: #selector(handleRGBHexColorChange), for: .editingChanged)
        greenHexField.addTarget(self, action: #selector(handleRGBHexColorChange), for: .editingChanged)
        blueHexField.addTarget(self, action: #selector(handleRGBHexColorChange), for: .editingChanged)
    }
    
    private func createHexTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = Constants.Colors.white
        textField.textAlignment = .center
        textField.keyboardType = .asciiCapable
        textField.autocapitalizationType = .allCharacters
        textField.setHeight(Constants.WishMaker.textFieldHeight)
        return textField
    }
    
    private func configureColorPicker() {
        pickerStack = UIStackView()
        pickerStack.axis = .vertical
        pickerStack.spacing = Constants.WishMaker.stackSpacing
        view.addSubview(pickerStack)
        pickerStack.layer.cornerRadius = Constants.Common.cornerRadiusLarge
        pickerStack.clipsToBounds = true
        pickerStack.layoutMargins = UIEdgeInsets(
            top: Constants.WishMaker.stackPadding,
            left: Constants.WishMaker.stackPadding,
            bottom: Constants.WishMaker.stackPadding,
            right: Constants.WishMaker.stackPadding
        )
        pickerStack.isLayoutMarginsRelativeArrangement = true
        
        pickerTitleLabel = UILabel()
        pickerTitleLabel.text = "Color Picker"
        pickerTitleLabel.font = UIFont.boldSystemFont(ofSize: Constants.FontSizes.body)
        pickerTitleLabel.textColor = Constants.Colors.white
        pickerTitleLabel.textAlignment = .center
        
        pickerButton = UIButton(type: .system)
        pickerButton.setTitle(Constants.WishMaker.pickerButtonTitle, for: .normal)
        pickerButton.backgroundColor = Constants.Colors.white
        pickerButton.setTitleColor(Constants.Colors.primary, for: .normal)
        pickerButton.layer.cornerRadius = Constants.Common.cornerRadius
        pickerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.FontSizes.body)
        pickerButton.setHeight(Constants.WishMaker.buttonHeight)
        pickerButton.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        
        pickerStack.addArrangedSubview(pickerTitleLabel)
        pickerStack.addArrangedSubview(pickerButton)
        
        pickerStack.pinCenterX(to: view)
        pickerStack.pinLeft(to: view, Constants.WishMaker.stackLeading)
        pickerStack.pinTop(to: switchButton.bottomAnchor, Constants.Common.defaultSpace)
    }
    
    // MARK: - UI Updates
    private func updateUI() {
        sliderStack.isHidden = true
        hexStack.isHidden = true
        pickerStack.isHidden = true
        
        switch currentInputMode {
        case .sliders:
            sliderStack.isHidden = false
        case .hex:
            hexStack.isHidden = false
        case .picker:
            pickerStack.isHidden = false
        }
    }
    
    private func updateButtonTitle() {
        let title: String
        switch currentInputMode {
        case .sliders:
            title = Constants.WishMaker.switchToHexTitle
        case .hex:
            title = Constants.WishMaker.switchToPickerTitle
        case .picker:
            title = Constants.WishMaker.switchToSlidersTitle
        }
        switchButton.setTitle("Switch to \(title)", for: .normal)
    }
    
    // MARK: - User Actions
    @objc private func switchInputMode() {
        presenter?.didChangeInputMode()
    }
    
    @objc private func handleSliderColorChange() {
        let red = sliderRed.slider.value
        let green = sliderGreen.slider.value
        let blue = sliderBlue.slider.value
        presenter?.didChangeColorViaSliders(red: red, green: green, blue: blue)
    }
    
    @objc private func handleHexColorChange() {
        guard let hexText = hexTextField.text else { return }
        presenter?.didChangeColorViaHex(hex: hexText)
    }
    
    @objc private func handleRGBHexColorChange() {
        guard let redHex = redHexField.text, !redHex.isEmpty,
              let greenHex = greenHexField.text, !greenHex.isEmpty,
              let blueHex = blueHexField.text, !blueHex.isEmpty else { return }
        
        presenter?.didChangeColorViaRGBHex(red: redHex, green: greenHex, blue: blueHex)
    }
    
    @objc private func openColorPicker() {
        guard currentInputMode == .picker else { return }
        
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = view.backgroundColor ?? Constants.Colors.defaultBackground
        colorPicker.supportsAlpha = false
        
        if #available(iOS 15.0, *) {
            colorPicker.view.tintColor = Constants.Colors.primary
        }
        
        present(colorPicker, animated: true)
    }
    
    @objc private func addWishButtonPressed() {
        presenter?.didPressAddWishButton()
    }
    
    // MARK: - Accessibility
    private func setupAccessibility() {
        titleView.accessibilityLabel = Constants.Accessibility.WishMaker.titleLabel
        addWishButton.accessibilityLabel = Constants.Accessibility.WishMaker.addWishButton
        switchButton.accessibilityLabel = Constants.Accessibility.WishMaker.switchModeButton
        pickerButton.accessibilityLabel = Constants.Accessibility.WishMaker.colorPickerButton
        hexTextField.accessibilityLabel = Constants.Accessibility.WishMaker.hexTextField
        redHexField.accessibilityLabel = Constants.Accessibility.WishMaker.redHexField
        greenHexField.accessibilityLabel = Constants.Accessibility.WishMaker.greenHexField
        blueHexField.accessibilityLabel = Constants.Accessibility.WishMaker.blueHexField
        
        // Sliders accessibility
        sliderRed.titleView.accessibilityLabel = Constants.Accessibility.WishMaker.redSlider
        sliderGreen.titleView.accessibilityLabel = Constants.Accessibility.WishMaker.greenSlider
        sliderBlue.titleView.accessibilityLabel = Constants.Accessibility.WishMaker.blueSlider
    }
}

// MARK: - WishMakerViewProtocol
extension WishMakerViewController: WishMakerViewProtocol {
    func updateBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    func updateHexFields(red: String, green: String, blue: String, fullHex: String) {
        redHexField.text = red
        greenHexField.text = green
        blueHexField.text = blue
        hexTextField.text = fullHex
    }
    
    func updateSliders(red: Float, green: Float, blue: Float) {
        sliderRed.slider.value = red
        sliderGreen.slider.value = green
        sliderBlue.slider.value = blue
        sliderRed.updateValueLabel(value: Double(red))
        sliderGreen.updateValueLabel(value: Double(green))
        sliderBlue.updateValueLabel(value: Double(blue))
    }
    
    func updateUIForMode(_ mode: InputMode) {
        currentInputMode = mode
        updateUI()
        updateButtonTitle()
    }
    
    func updateButtonTitle(_ title: String) {
        switchButton.setTitle(title, for: .normal)
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension WishMakerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            presenter?.didSelectColorFromPicker(color)
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        presenter?.didSelectColorFromPicker(viewController.selectedColor)
        viewController.dismiss(animated: true)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        presenter?.didSelectColorFromPicker(viewController.selectedColor)
    }
}
