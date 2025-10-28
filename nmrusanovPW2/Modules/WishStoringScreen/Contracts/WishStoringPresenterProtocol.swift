//
//  WishStoringPresenterProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//


protocol WishStoringPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddWish(_ wishText: String)
    func didTapDeleteWish(at index: Int)
    func didTapEditWish(at index: Int, newText: String)
    func didTapShareWish(at index: Int)
}
