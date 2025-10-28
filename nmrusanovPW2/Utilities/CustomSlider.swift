//
//  customSlider.swift
//  nmrusanovPW2
//
//  Created by Nick on 22.09.2025.
//

import UIKit

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    var valueLabel = UILabel() // Добавляем лейбл для отображения значения
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Constants.Colors.white
        translatesAutoresizingMaskIntoConstraints = false
        
        // Настраиваем valueLabel
        valueLabel.text = String(format: Constants.CustomSlider.valueLabelFormat, 0.0)
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont.monospacedDigitSystemFont(ofSize: Constants.FontSizes.small, weight: .regular)
        valueLabel.textColor = Constants.Colors.textSecondary
        
        for view in [slider, titleView, valueLabel] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.CustomSlider.titleTopInset),
            titleView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Constants.CustomSlider.titleLeadingInset),
            
            valueLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.CustomSlider.valueLabelTrailingInset),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleView.trailingAnchor, constant: Constants.Common.smallSpace),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.CustomSlider.sliderTopOffset),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.CustomSlider.sliderBottomInset),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.CustomSlider.sliderHorizontalInset),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.CustomSlider.sliderHorizontalInset)
        ])
    }
    
    func updateValueLabel(value: Double) {
        valueLabel.text = String(format: Constants.CustomSlider.valueLabelFormat, value)
    }
    
    @objc
    private func sliderValueChanged() {
        let value = Double(slider.value)
        updateValueLabel(value: value)
        valueChanged?(value)
    }
}
