//
//  AddWishCell.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class AddWishCell: UITableViewCell {
    
    // MARK: - UI Elements
    private var textField: UITextField!
    private var addButton: UIButton!
    var onAddWish: ((String) -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let containerView = UIView()
        containerView.backgroundColor = Constants.Colors.white
        containerView.layer.cornerRadius = Constants.Common.cornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        textField = UITextField()
        textField.placeholder = Constants.WishStoring.newWishPlaceholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        addButton = UIButton(type: .system)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.FontSizes.title)
        addButton.backgroundColor = Constants.Colors.primary
        addButton.setTitleColor(Constants.Colors.white, for: .normal)
        addButton.layer.cornerRadius = Constants.Common.cornerRadius
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(textField)
        containerView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Common.smallSpace),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Common.defaultSpace),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Common.defaultSpace),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Common.smallSpace),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Common.defaultSpace),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.Common.defaultSpace),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.Common.defaultSpace),
            
            addButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.Common.smallSpace),
            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.Common.defaultSpace),
            addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: Constants.WishStoring.addButtonHeight),
            addButton.heightAnchor.constraint(equalToConstant: Constants.WishStoring.addButtonHeight)
        ])
    }
    
    // MARK: - Actions
    @objc private func addButtonTapped() {
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        onAddWish?(text)
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    // MARK: - Public Methods
    func configure(onAddWish: @escaping (String) -> Void) {
        self.onAddWish = onAddWish
    }
}
