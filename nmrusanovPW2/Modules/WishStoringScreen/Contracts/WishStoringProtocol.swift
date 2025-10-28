//
//  WishStoringProtocol.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

protocol WishStoringRouterProtocol: AnyObject {
    func navigateBackToWishMaker()
    static func createWishStoringModule() -> UIViewController
}
