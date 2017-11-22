//
//  User.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 03/11/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

struct User {
    let name: String

    init?(name: String?) {
        self.name = name ?? "[Unknown]"
    }
}
