//
//  PostCell.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    static let identifier = String(describing: PostCell.self)
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(userIdLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        return stackView
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        let attributedTitle = NSAttributedString(string: "ID: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        label.attributedText = attributedTitle
        label.numberOfLines = 0
        return label
    }()
    
    lazy var userIdLabel: UILabel = {
        let label = UILabel()
        let attributedTitle = NSAttributedString(string: "User ID: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        label.attributedText = attributedTitle
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        let attributedTitle = NSAttributedString(string: "Title: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        label.attributedText = attributedTitle
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        let attributedTitle = NSAttributedString(string: "Body: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        label.attributedText = attributedTitle
        label.numberOfLines = 0
        return label
    }()
    
    override func prepareForReuse() {
        idLabel.attributedText = NSAttributedString(string: "ID: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        userIdLabel.attributedText = NSAttributedString(string: "User ID: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        titleLabel.attributedText = NSAttributedString(string: "Title: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        bodyLabel.attributedText = NSAttributedString(string: "Body: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
    }
    
    func setupCell(for post: Post) {
        idLabel.setAttributedTitle(title: "\(post.id)")
        userIdLabel.setAttributedTitle(title: "\(post.userId)")
        titleLabel.setAttributedTitle(title: post.title)
        bodyLabel.setAttributedTitle(title: post.body)
        
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            containerStackView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            containerStackView.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor)
            ])
    }
    
    func makeAttributedTitle(for label: UILabel, usingTitle title: String) -> NSAttributedString {
        guard let defaultAttributedText = label.attributedText else {
            return NSAttributedString(string: title)
        }
        let attributedTitle = NSMutableAttributedString(attributedString: defaultAttributedText)
        attributedTitle.append(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)]))
        return attributedTitle
    }
}

// MARK: - PostCell Utils

private extension UILabel {
    
    func setAttributedTitle(title: String) {
        guard let defaultAttributedText = attributedText else {
            attributedText = NSAttributedString(string: title)
            return
        }
        let attributedTitle = NSMutableAttributedString(attributedString: defaultAttributedText)
        attributedTitle.append(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)]))
        attributedText = attributedTitle
    }
}
