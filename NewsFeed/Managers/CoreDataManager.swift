//
//  CoreDataManager.swift
//  NewsFeed
//
//  Created by Ксения Маричева on 10.03.2025.
//

import UIKit
import CoreData

class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    private var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    private var context: NSManagedObjectContext? {
        appDelegate?.persistentContainer.viewContext
    }
    
    func savePost(_ post: Post, avatar: Data) {
        guard fetchPostById(post.id) == nil, let context else { return }
        let savedPost = SavedPost(context: context)
        savedPost.id = Int32(post.id)
        savedPost.title = post.title
        savedPost.text = post.body
        savedPost.avatar = avatar
        appDelegate?.saveContext()
    }
    
    func fetchPostById(_ id: Int) -> SavedPost? {
        let fetchRequest = SavedPost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        return (try? context?.fetch(fetchRequest))?.first
    }
    
    func fetchPosts() -> [SavedPost] {
        (try? context?.fetch(SavedPost.fetchRequest())) ?? []
    }
    
    func deletePosts() {
        fetchPosts().forEach { context?.delete($0) }
        appDelegate?.saveContext()
    }
}
