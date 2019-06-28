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
    
    func setupCell(for post: Post) {
        textLabel?.text = "\(post.userId) - " + post.title
        textLabel?.numberOfLines = 0
    }
    
}
