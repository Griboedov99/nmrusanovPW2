//
//  WishStoringviewController.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    // MARK: - UI Elements
    private var tableView: UITableView!
    private var emptyStateLabel: UILabel!
    
    // MARK: - VIPER
    var presenter: WishStoringPresenterProtocol?
    
    // MARK: - Data
    private var wishes: [Wish] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
        setupAccessibility()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Constants.Colors.background
        title = Constants.WishStoring.title
        navigationItem.largeTitleDisplayMode = .never
        
        configureTableView()
        configureEmptyState()
        setupConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.register(AddWishCell.self, forCellReuseIdentifier: Constants.WishStoring.addWishCellIdentifier)
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: Constants.WishStoring.writtenWishCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func configureEmptyState() {
        emptyStateLabel = UILabel()
        emptyStateLabel.text = Constants.WishStoring.emptyStateText
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = Constants.Colors.systemGray
        emptyStateLabel.font = UIFont.systemFont(ofSize: Constants.FontSizes.body)
        emptyStateLabel.isHidden = true
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Common.defaultSpace),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Common.defaultSpace)
        ])
    }
    
    // MARK: - Actions
    private func showEditWishAlert(for wish: Wish, at index: Int) {
        let alert = UIAlertController(
            title: Constants.WishStoring.editWishTitle,
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = wish.text
        }
        
        let saveAction = UIAlertAction(title: Constants.WishStoring.saveActionTitle, style: .default) { [weak self] _ in
            guard let newText = alert.textFields?.first?.text else { return }
            self?.presenter?.didTapEditWish(at: index, newText: newText)
        }
        
        let cancelAction = UIAlertAction(title: Constants.WishStoring.cancelActionTitle, style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showDeleteConfirmation(for index: Int) {
        let alert = UIAlertController(
            title: Constants.Alerts.deleteWishTitle,
            message: Constants.Alerts.deleteWishMessage,
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: Constants.WishStoring.deleteActionTitle, style: .destructive) { [weak self] _ in
            self?.presenter?.didTapDeleteWish(at: index)
        }
        
        let cancelAction = UIAlertAction(title: Constants.WishStoring.cancelActionTitle, style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Accessibility
    private func setupAccessibility() {
        tableView.accessibilityLabel = Constants.Accessibility.WishStoring.tableView
        emptyStateLabel.accessibilityLabel = Constants.Accessibility.WishStoring.emptyStateText
    }
}

// MARK: - UITableViewDataSource & Delegate
extension WishStoringViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return wishes.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WishStoring.addWishCellIdentifier, for: indexPath) as! AddWishCell
            cell.configure { [weak self] wishText in
                self?.presenter?.didTapAddWish(wishText)
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WishStoring.writtenWishCellIdentifier, for: indexPath) as! WrittenWishCell
            let wish = wishes[indexPath.row]
            cell.configure(with: wish) { [weak self] in
                self?.presenter?.didTapShareWish(at: indexPath.row)
            } onEdit: { [weak self] in
                self?.showEditWishAlert(for: wish, at: indexPath.row)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return Constants.WishStoring.addWishCellHeight
        case 1: return Constants.WishStoring.writtenWishCellHeight
        default: return UITableView.automaticDimension
        }
    }
    
    // MARK: - Delete Methods
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 // Only written wishes can be deleted
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == 1 {
            showDeleteConfirmation(for: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return Constants.WishStoring.deleteActionTitle
    }
    
    // Optional: Custom swipe actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 1 else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            self?.showDeleteConfirmation(for: indexPath.row)
            completion(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - WishStoringViewProtocol
extension WishStoringViewController: WishStoringViewProtocol {
    func displayWishes(_ wishes: [Wish]) {
        self.wishes = wishes
        tableView.reloadData()
        emptyStateLabel.isHidden = !wishes.isEmpty
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: Constants.Alerts.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Alerts.okActionTitle, style: .default))
        present(alert, animated: true)
    }
    
    func showEmptyState() {
        wishes = []
        tableView.reloadData()
        emptyStateLabel.isHidden = false
    }
    
    func showShareSheet(for text: String) {
        let activityViewController = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(activityViewController, animated: true)
    }
}
