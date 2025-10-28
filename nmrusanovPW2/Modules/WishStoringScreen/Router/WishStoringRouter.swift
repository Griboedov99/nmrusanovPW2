//
//  WishStoringRouter.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

final class WishStoringRouter: WishStoringRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createWishStoringModule() -> UIViewController {
        let view = WishStoringViewController()
        let presenter = WishStoringPresenter()
        let interactor = WishStoringInteractor()
        let router = WishStoringRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateBackToWishMaker() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
