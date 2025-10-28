//
//  WrittenWishCell.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    
    // MARK: - UI Elements
    private var wishLabel: UILabel!
    private var dateLabel: UILabel!
    private var shareButton: UIButton!
    
    var onShare: (() -> Void)?
    var onEdit: (() -> Void)?
    
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
        
        wishLabel = UILabel()
        wishLabel.font = UIFont.systemFont(ofSize: Constants.FontSizes.body, weight: .medium)
        wishLabel.textColor = Constants.Colors.textPrimary
        wishLabel.numberOfLines = 2
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: Constants.FontSizes.small)
        dateLabel.textColor = Constants.Colors.textSecondary
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = Constants.Colors.primary
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(wishLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Common.smallSpace / 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Common.defaultSpace),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Common.defaultSpace),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Common.smallSpace / 2),
            
            wishLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Common.smallSpace),
            wishLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.Common.defaultSpace),
            wishLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -Constants.Common.smallSpace),
            
            dateLabel.topAnchor.constraint(equalTo: wishLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: wishLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.Common.smallSpace),
            
            shareButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.Common.defaultSpace),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Add tap gesture for editing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func shareButtonTapped() {
        onShare?()
    }
    
    @objc private func cellTapped() {
        onEdit?()
    }
    
    // MARK: - Public Methods
    func configure(with wish: Wish, onShare: @escaping () -> Void, onEdit: @escaping () -> Void) {
        wishLabel.text = wish.text
        dateLabel.text = formatDate(wish.createdAt)
        self.onShare = onShare
        self.onEdit = onEdit
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
