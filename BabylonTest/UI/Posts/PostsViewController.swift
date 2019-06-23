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
        view.addSubview(postsTableView)
        
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            postsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ])
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
    }
}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - AllPostsViewModelDelegate

extension PostsViewController: PostsViewModelDelegate {
    
    func didReceivePosts(_ posts: [Post]) {
        self.posts = posts
        postsTableView.reloadSections([0], with: .automatic)
    }
    
    func didThrowError(_ error: Error) {
        print("🔥", error)
    }
}
