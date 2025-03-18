//
//  Entity.swift
//  Feed
//
//  Created by Ксения Маричева on 06.03.2025.
//

import UIKit

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    
    var image: UIImage?
    
    enum CodingKeys: CodingKey {
        case id, title, body
    }
}

extension [Post] {
    var extended: [Post] {
        map {
            if let savedPost = CoreDataManager.shared.fetchPostById($0.id) {
                return savedPost.toPost
            }
            return $0
        }
    }
}

extension SavedPost {
    var toPost: Post {
        var post = Post(id: Int(id), title: title ?? "", body: text ?? "")
        guard let avatar else { return post }
        post.image = UIImage(data: avatar)
        return post
    }
}
