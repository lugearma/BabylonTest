//
//  APIClient.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/22/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIClientError: Error {
    case missingData
}

protocol APIClientProtocol {
    func posts(completion: @escaping PostsResult)
    func postBy(id: String, completion: @escaping PostResult)
}

typealias PostsResult = (Result<[Post], Error>) -> Void
typealias PostResult = (Result<Post, Error>) -> Void

class APIClient: APIClientProtocol {
    
    func posts(completion: @escaping PostsResult) {
        requestData(requestType: .get, router: .posts, completion: completion)
    }
    
    func postBy(id: String, completion: @escaping PostResult) {
        requestData(requestType: .get, router: .postBy(id: id), completion: completion)
    }
}

extension APIClient {
    // TODO: Modify this to Codable.
    func requestData<T: Decodable>(requestType: RequestType, router: APIRouter, parameters: [String : Any] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        let url = router.composedURL
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(APIClientError.missingData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let type = try decoder.decode(T.self, from: data)
                completion(.success(type))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
