//
//  WishMakerBuilder.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishMakerBuilder {
    static func build() -> UIViewController {
        return WishMakerRouter.createWishMakerModule()
    }
}
