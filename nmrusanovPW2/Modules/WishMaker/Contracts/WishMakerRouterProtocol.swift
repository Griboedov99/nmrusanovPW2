//
//  WishMakerRouterProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishMakerRouterProtocol: AnyObject {
    func navigateToWishList()
    static func createWishMakerModule() -> UIViewController
}
