//
//  APIRouter.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation


enum APIRouter {
    case posts
    case postBy(id: String)
}

extension APIRouter {
    
    var baseURL: String {
        return "http://jsonplaceholder.typicode.com"
    }
    
    private var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .postBy(let id):
            return "/posts/\(id)"
        }
    }
    
    var composedURL: URL {
        guard let url = URL(string: baseURL + self.path) else {
            preconditionFailure("Unable to make URL")
        }
        return url
    }
}
