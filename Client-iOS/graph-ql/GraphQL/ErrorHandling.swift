//
//  AlertError.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 19/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation
import Apollo

enum RequestResult<T> {
    case success(T)
    case error(RequestError)
}

enum RequestError: CustomStringConvertible {
    case error(Error)
    case graphQLError([GraphQLError])
    case withoutData

    static func check(resultErrors: [GraphQLError]?, error: Error?) -> RequestError? {
        if let error = error {
            return .error(error)
        }

        if let result = resultErrors {
            return .graphQLError(result)
        }

        return nil
    }

    var description: String {
        switch self {
        case .error(let error):
            return "\(error)"
        case .graphQLError(let errors):
            return errors
                .map { $0.message }
                .map { $0.split(separator: ":", maxSplits: 1) }
                .flatMap { $0.last }
                .joined(separator: "\n\n")
        case .withoutData:
            return "Could not retrieve the data"
        }
    }
}

extension UIViewController {
    func showAlertError(_ requestError: RequestError) {
        let alert = UIAlertController(title: "Error!", message: "\(requestError)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
