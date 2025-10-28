//
//  WishStoringInteractor.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishStoringInteractorOutputProtocol: AnyObject {
    func didFetchWishes(_ wishes: [Wish])
    func didAddWish(_ wish: Wish)
    func didDeleteWish(at index: Int)
    func didUpdateWish(_ wish: Wish)
    func didReceiveError(_ error: String)
}

final class WishStoringInteractor: WishStoringInteractorProtocol {
    weak var presenter: WishStoringPresenterProtocol?
    private weak var output: WishStoringInteractorOutputProtocol? {
        return presenter as? WishStoringInteractorOutputProtocol
    }
    
    private var wishes: [Wish] = []
    
    // MARK: - UserDefaults
    private var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    // MARK: - Lifecycle
    init() {
        loadWishes()
    }
    
    // MARK: - Data Management
    private func loadWishes() {
        if let data = userDefaults.data(forKey: Constants.WishStoring.wishesUserDefaultsKey),
           let savedWishes = try? JSONDecoder().decode([Wish].self, from: data) {
            wishes = savedWishes
        }
    }
    
    private func saveWishes() {
        if let data = try? JSONEncoder().encode(wishes) {
            userDefaults.set(data, forKey: Constants.WishStoring.wishesUserDefaultsKey)
        }
    }
    
    // MARK: - WishStoringInteractorProtocol
    func fetchWishes() {
        output?.didFetchWishes(wishes)
    }
    
    func addWish(_ text: String) {
        let newWish = Wish(text: text)
        wishes.append(newWish)
        saveWishes()
        output?.didAddWish(newWish)
    }
    
    func deleteWish(at index: Int) {
        guard index >= 0 && index < wishes.count else {
            output?.didReceiveError(Constants.Alerts.invalidIndexError)
            return
        }
        
        wishes.remove(at: index)
        saveWishes()
        output?.didDeleteWish(at: index)
    }
    
    func updateWish(at index: Int, newText: String) {
        guard index >= 0 && index < wishes.count else {
            output?.didReceiveError(Constants.Alerts.invalidIndexError)
            return
        }
        
        wishes[index].text = newText
        saveWishes()
        output?.didUpdateWish(wishes[index])
    }
    
    func getWish(at index: Int) -> Wish? {
        guard index >= 0 && index < wishes.count else { return nil }
        return wishes[index]
    }
}
