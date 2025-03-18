//
//  FeedPresenter.swift
//  Feed
//
//  Created by Ксения Маричева on 04.03.2025.
//

import UIKit

protocol FeedPresenterProtocol: AnyObject {
    func contentAwaited()
    func setPosts(_ posts: [Post])
    func avatarAwaited(at indexPath: IndexPath)
    func setAvatar(_ avatar: UIImage?, forRowAt indexPath: IndexPath)
}

class FeedPresenter {
    
    //MARK: - naming
    weak var view: FeedViewControllerProtocol?
    var router: FeedRouterProtocol
    var interactor: FeedInteractorProtocol
    
    //MARK: - init
    init(router: FeedRouterProtocol, interactor: FeedInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension FeedPresenter: FeedPresenterProtocol {
    
    func contentAwaited() {
        interactor.contentAwaited()
    }
    
    func setPosts(_ posts: [Post]) {
        view?.setPosts(posts)
    }
    
    func avatarAwaited(at indexPath: IndexPath) {
        interactor.fetchPhoto(for: indexPath)
    }
    
    func setAvatar(_ avatar: UIImage?, forRowAt indexPath: IndexPath) {
        view?.setAvatar(avatar, forRowAt: indexPath)
    }
}
