//
//  Comment.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/25/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
