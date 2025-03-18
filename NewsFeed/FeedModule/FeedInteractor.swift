//
//  FeedInteractor.swift
//  Feed
//
//  Created by Ксения Маричева on 04.03.2025.
//

import UIKit
import Alamofire
import Network

protocol FeedInteractorProtocol: AnyObject {
    func contentAwaited()
    func fetchPhoto(for indexPath: IndexPath)
}

class FeedInteractor {
    
    weak var presenter: FeedPresenterProtocol?
    private var posts: [Post] = []
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared

    func fetchPosts() {
        networkManager.checkConnection { [weak self] isAvailable in
            guard let self else { return }
            isAvailable ?
            networkManager.fetchPosts { self.setupPosts($0.extended) }
            : setupPosts(coreDataManager.fetchPosts().map { $0.toPost })
        }
    }
    
    func setupPosts(_ posts: [Post]) {
        self.posts = posts
        self.presenter?.setPosts(posts)
    }
}

extension FeedInteractor: FeedInteractorProtocol {
    
    func contentAwaited() {
        fetchPosts()
    }
    
    func fetchPhoto(for indexPath: IndexPath) {
        
        let post = posts[indexPath.row]
        
        networkManager.fetchPhotoData(by: post.id) { [weak self] data in
            guard let self else { return }
            self.coreDataManager.savePost(post, avatar: data)
            self.presenter?.setAvatar(UIImage(data: data), forRowAt: indexPath)
        }
    }
}
