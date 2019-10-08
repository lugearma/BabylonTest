//
//  PostsViewController.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {
    
    private let viewModel: PostsViewModel
    private let postsTableView = UITableView()
    private var posts: [Post] = []
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPosts()
        setupTableView()
        title = "Posts"
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        let segmentControl = UISegmentedControl()
        
        if #available(iOS 13.0, *) {
            segmentControl.selectedSegmentTintColor = .green
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func setupTableView() {
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 100
        postsTableView.refreshControl = refreshControl
        view.addSubview(postsTableView)
        
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            postsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ])
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
    }
    
    @objc func refreshData() {
        viewModel.fetchPosts()
        print(#function)
    }
}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
            preconditionFailure("Couldn't load cell with identifier: \(PostCell.identifier)")
        }
        let post = posts[indexPath.row]
        cell.setupCell(for: post)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        viewModel.pushToPostDetail(post: post)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - AllPostsViewModelDelegate

extension PostsViewController: PostsViewModelDelegate {
    
    func didReceivePosts(_ posts: [Post]) {
        self.posts = posts
        postsTableView.reloadSections([0], with: .automatic)
        refreshControl.endRefreshing()
    }
    
    func didThrow(_ error: Error) {
        let alert = UIAlertController.basicErrorAlert(error: error)
        present(alert, animated: true)
    }
}
