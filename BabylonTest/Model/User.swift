//
//  User.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/22/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let addres: Address
    let phone: Int
    let website: String
    let company: Company
}
