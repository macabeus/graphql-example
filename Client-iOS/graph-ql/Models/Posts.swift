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

    init?(id: Int?, name: String?, body: String?, countLikes: Int?, liked: Bool?, author: User?) {
        guard
            let id = id,
            let countLikes = countLikes,
            let liked = liked,
            let author = author else {
                return nil
        }

        self.id = id
        self.name = name ?? "[No title]"
        self.body = body ?? ""
        self.countLikes = countLikes
        self.liked = liked
        self.author = author
    }
}
