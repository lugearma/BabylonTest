//
//  Post.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/22/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
