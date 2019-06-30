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
    case userBy(id: String)
    case commentsBy(postId: String)
}

extension APIRouter {
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "jsonplaceholder.typicode.com"
        return components
    }
    
    private var path: String {
        switch self {
        case .posts:
            return "posts"
        case .userBy(let id):
            return "users/\(id)"
        case .commentsBy:
            return "comments"
        }
    }
    
    private var components: URLComponents {
        switch self {
        case .posts:
            return baseComponents
        case .userBy:
            return baseComponents
        case .commentsBy(let postId):
            var mutableBaseComponents = baseComponents
            mutableBaseComponents.queryItems = [URLQueryItem(name: "postId", value: postId)]
            return mutableBaseComponents
        }
    }
    
    var composedURL: URL {
        guard let url = components.url else {
            preconditionFailure("Couldn't get the URL")
        }
        return url.appendingPathComponent(path)
    }
}
