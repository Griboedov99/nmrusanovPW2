//
//  WishStoringBuilder.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishStoringBuilder {
    static func build() -> UIViewController {
        return WishStoringRouter.createWishStoringModule()
    }
}
