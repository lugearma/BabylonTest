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
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(userIdLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        return stackView
    }()
    
    private lazy var idLabel = makeFieldDescriptionLabel(fieldType: .id)
    private lazy var userIdLabel = makeFieldDescriptionLabel(fieldType: .userId)
    private lazy var titleLabel = makeFieldDescriptionLabel(fieldType: .title)
    private lazy var bodyLabel = makeFieldDescriptionLabel(fieldType: .body)
    
    override func prepareForReuse() {
        idLabel.setDefaultTitle(fieldType: .id)
        userIdLabel.setDefaultTitle(fieldType: .userId)
        titleLabel.setDefaultTitle(fieldType: .title)
        bodyLabel.setDefaultTitle(fieldType: .body)
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
    
    private func makeFieldDescriptionLabel(fieldType type: UILabel.PostField) -> UILabel {
        let label = UILabel()
        label.setDefaultTitle(fieldType: type)
        label.numberOfLines = 0
        return label

    }
    
    private func makeAttributedTitle(for label: UILabel, usingTitle title: String) -> NSAttributedString {
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
    
    enum PostField {
        case id
        case userId
        case title
        case body
        
        var description: String {
            switch self {
            case .id:
                return "ID: "
            case .userId:
                return "User ID: "
            case .title:
                return "Title: "
            case .body:
                return "Body: "
            }
        }
    }
    
    func setDefaultTitle(fieldType type: PostField) {
        let attributedTitle = NSAttributedString(string: type.description, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold)])
        attributedText = attributedTitle
    }
    
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
