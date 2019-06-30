//
//  PostDetailView.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/25/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

struct PostDetail {
    let user: User
    let body: String
    let numberOfComments: Int
}

class PostDetailView: UIView {
    
    private let user: User
    private let body: String
    private let numberOfComments: Int
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(authorNameLabel)
        stackView.addArrangedSubview(postDescriptionLabel)
        stackView.addArrangedSubview(numberOfCommentsLabel)
        return stackView
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Author Name: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
        attributedString.append(NSAttributedString(string: user.name))
        label.attributedText = attributedString
        return label
    }()
    
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Description: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
        attributedString.append(NSAttributedString(string: body))
        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var numberOfCommentsLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Number of comments: ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
        attributedString.append(NSAttributedString(string: "\(numberOfComments)"))
        label.attributedText = attributedString
        return label
    }()
    
    init(postDetail: PostDetail) {
        self.user = postDetail.user
        self.body = postDetail.body
        self.numberOfComments = postDetail.numberOfComments
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            containerStackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            containerStackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            ])
    }
}
