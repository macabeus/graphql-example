//
//  Posts.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 16/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

struct Post {
    let id: Int
    let name: String
    let body: String
    var countLikes: Int
    var liked: Bool
    let author: User
}
