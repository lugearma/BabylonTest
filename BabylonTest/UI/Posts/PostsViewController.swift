//
//  PostsViewController.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {
    
    let viewModel: PostsViewModel
    let postsTableView = UITableView()
    var posts: [Post] = []
    
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
    }
    
    private func setupTableView() {
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 100
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
    }
    
    func didThrow(_ error: Error) {
        print("🔥", error)
    }
}
