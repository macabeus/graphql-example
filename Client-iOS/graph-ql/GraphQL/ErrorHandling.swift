//
//  AlertError.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 19/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation
import Apollo

extension Sequence where Iterator.Element == GraphQLError {
    func humanlyReadable() -> String {
        return self
            .map { $0.message }
            .map { $0.split(separator: ":", maxSplits: 1) }
            .flatMap { $0.last }
            .joined(separator: "\n\n")
    }
}
