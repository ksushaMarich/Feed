//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Ксения Маричева on 10.03.2025.
//

import Network
import Alamofire
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func checkConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            monitor.cancel()
            DispatchQueue.main.async {
                //completion(path.status == .satisfied)
                completion(true)
            }
        }
        monitor.start(queue: .global(qos: .background))
    }
    
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        AF.request(url).responseDecodable(of: [Post].self) { response in
            switch response.result {
            case .success(let posts):
                completion(posts)
            case .failure(let error):
                print("Ошибка загрузки:", error)
            }
        }
    }
    
    func fetchPhotoData(by id: Int, completion: @escaping (Data) -> Void) {
        
        let url = "https://picsum.photos/id/\(id)/200"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Ошибка загрузки \(error.localizedDescription)")
            }
        }
    }
}
