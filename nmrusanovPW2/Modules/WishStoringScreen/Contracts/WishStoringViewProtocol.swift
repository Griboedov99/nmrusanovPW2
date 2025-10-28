//
//  WishStoringViewProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishStoringViewProtocol: AnyObject {
    var presenter: WishStoringPresenterProtocol? { get set }
    
    func displayWishes(_ wishes: [Wish])
    func showError(message: String)
    func showEmptyState()
    func showShareSheet(for text: String)
}
