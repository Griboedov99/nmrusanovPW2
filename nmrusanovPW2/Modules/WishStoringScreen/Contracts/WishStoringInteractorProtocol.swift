//
//  WishStoringInteractorProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishStoringInteractorProtocol: AnyObject {
    var presenter: WishStoringPresenterProtocol? { get set }
    
    func fetchWishes()
    func addWish(_ text: String)
    func deleteWish(at index: Int)
    func updateWish(at index: Int, newText: String)
    func getWish(at index: Int) -> Wish?
}
