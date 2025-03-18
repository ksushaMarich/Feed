//
//  FeedRouter.swift
//  Feed
//
//  Created by Ксения Маричева on 04.03.2025.
//

import Foundation

protocol FeedRouterProtocol: AnyObject {
    
}

class FeedRouter {
    
    weak var view: FeedViewControllerProtocol?
    
    static func build() -> FeedViewController {
        let router = FeedRouter()
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(router: router, interactor: interactor)
        let viewController = FeedViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}

extension FeedRouter: FeedRouterProtocol {
    
}
