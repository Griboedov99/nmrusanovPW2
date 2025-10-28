final class WishStoringPresenter: WishStoringPresenterProtocol {
    weak var view: WishStoringViewProtocol?
    var interactor: WishStoringInteractorProtocol?
    var router: WishStoringRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchWishes()
    }
    
    func didTapAddWish(_ wishText: String) {
        guard !wishText.trimmingCharacters(in: .whitespaces).isEmpty else {
            view?.showError(message: "Wish cannot be empty")
            return
        }
        
        interactor?.addWish(wishText)
    }
    
    func didTapDeleteWish(at index: Int) {
        interactor?.deleteWish(at: index)
    }
    
    func didTapEditWish(at index: Int, newText: String) {
        guard !newText.trimmingCharacters(in: .whitespaces).isEmpty else {
            view?.showError(message: "Wish cannot be empty")
            return
        }
        
        interactor?.updateWish(at: index, newText: newText)
    }
    
    func didTapShareWish(at index: Int) {
        guard let wish = interactor?.getWish(at: index) else { return }
        view?.showShareSheet(for: wish.text)
    }
}

// MARK: - WishStoringInteractorOutputProtocol
extension WishStoringPresenter: WishStoringInteractorOutputProtocol {
    func didFetchWishes(_ wishes: [Wish]) {
        if wishes.isEmpty {
            view?.showEmptyState()
        } else {
            view?.displayWishes(wishes)
        }
    }
    
    func didAddWish(_ wish: Wish) {
        interactor?.fetchWishes() // Refresh the list
    }
    
    func didDeleteWish(at index: Int) {
        interactor?.fetchWishes() // Refresh the list
    }
    
    func didUpdateWish(_ wish: Wish) {
        interactor?.fetchWishes() // Refresh the list
    }
    
    func didReceiveError(_ error: String) {
        view?.showError(message: error)
    }
}
