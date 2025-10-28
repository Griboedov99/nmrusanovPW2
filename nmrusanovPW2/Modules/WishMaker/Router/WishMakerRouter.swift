//
//  WishMakerRouter.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishMakerRouter: WishMakerRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createWishMakerModule() -> UIViewController {
        let view = WishMakerViewController()
        let presenter = WishMakerPresenter()
        let interactor = WishMakerInteractor()
        let router = WishMakerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToWishList() {
        let wishStoringVC = WishStoringBuilder.build()
        viewController?.navigationController?.pushViewController(wishStoringVC, animated: true)
    }
}
