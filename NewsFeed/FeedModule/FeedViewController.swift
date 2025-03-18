//
//  FeedViewController.swift
//  Feed
//
//  Created by Ксения Маричева on 04.03.2025.
//

import UIKit

protocol FeedViewControllerProtocol: AnyObject {
    func setPosts(_ posts: [Post])
    func setAvatar(_ avatar: UIImage?, forRowAt indexPath: IndexPath)
}

class FeedViewController: UIViewController {
    
    //MARK: - naming
    var presenter: FeedPresenterProtocol?
    
    private var posts: [Post] = []
    
    //top
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userАvatarView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "MyAvatar")
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News Feed"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    
    //feed
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = false
        view.separatorInset = .zero
        view.separatorColor = .systemGray
        let refreshControlCustom = UIRefreshControl()
        refreshControlCustom.addTarget(self, action: #selector(refreshCalled), for: .valueChanged)
        view.refreshControl = refreshControlCustom
        return view
    }()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        presenter?.contentAwaited()
        setupView()
    }
    
    //MARK: - methods
    func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(topView)
        topView.addSubview(userАvatarView)
        topView.addSubview(titleLabel)
        topView.addSubview(separatorView)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            // topView
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 40),
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            userАvatarView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            userАvatarView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: Constants.indent),
            userАvatarView.heightAnchor.constraint(equalToConstant: 30),
            userАvatarView.widthAnchor.constraint(equalTo: userАvatarView.heightAnchor),
            
            separatorView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            separatorView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    @objc private func refreshCalled() {
        presenter?.contentAwaited()
    }
}

extension FeedViewController: FeedViewControllerProtocol {
    
    func setPosts(_ posts: [Post]) {
        if tableView.refreshControl?.isRefreshing == true {
            tableView.refreshControl?.endRefreshing()
        }
        self.posts = posts
        tableView.reloadData()
    }
    
    func setAvatar(_ avatar: UIImage?, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PostCell else { return }
        cell.setAvatar(avatar)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell else { return UITableViewCell() }
        
        let post = posts[indexPath.row]
        cell.configure(title: post.title, text: post.body)
        
        if let image = post.image {
            cell.setAvatar(image)
        } else {
            presenter?.avatarAwaited(at: indexPath)
        }
        
        return cell
    }
}


