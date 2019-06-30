//
//  PostDetailViewController.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class PostDetailViewController: UIViewController {
    
    private let viewModel: PostDetailViewModel
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        return indicator
    }()
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Post detail"
        viewModel.fetchPostDetails()
        activityIndicator.startAnimating()
    }
    
    private func setupPostDetailView(_ postDetail: PostDetail) {
        let postDetailView = PostDetailView(postDetail: postDetail)
        postDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postDetailView)
        NSLayoutConstraint.activate([
            postDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            postDetailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            postDetailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            postDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

// MARK: - PostDetailViewModelDelegate

extension PostDetailViewController: PostDetailViewModelDelegate {
    
    func didReceivePostDetail(postDetail: PostDetail) {
        activityIndicator.stopAnimating()
        setupPostDetailView(postDetail)
    }
    
    func didThrow(_ error: Error) {
        let alert = UIAlertController.basicErrorAlert(error: error) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }
}
