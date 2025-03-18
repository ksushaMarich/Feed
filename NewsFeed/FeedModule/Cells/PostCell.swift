//
//  PostCell.swift
//  Feed
//
//  Created by Ксения Маричева on 06.03.2025.
//

import UIKit

class PostCell: UITableViewCell {

    //MARK: - naming
    static var identifier = "PostCell"
    
    private lazy var avatarView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 32
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarView.image = nil
        titleLabel.text = nil
        postLabel.text = nil
    }
    
    private func setupView() {
        
        let indent = Constants.indent
        
        addSubview(avatarView)
        addSubview(titleLabel)
        addSubview(postLabel)
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: topAnchor, constant: indent),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: indent),
            avatarView.heightAnchor.constraint(equalToConstant: 65),
            avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: avatarView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: indent),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -indent),
            
            postLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: indent),
            postLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            postLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            postLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -indent)
        ])
    }
    
    func configure(title: String, text: String) {
        titleLabel.text = title
        postLabel.text = text
    }
    
    func setAvatar(_ avatar: UIImage?) {
        avatarView.image = avatar
    }
}
