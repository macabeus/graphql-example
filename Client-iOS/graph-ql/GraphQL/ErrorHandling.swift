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

extension UIViewController {
    func showAlertErrorIfHave(resultErrors: [GraphQLError]?, error: Error?) -> Bool {
        if let error = error {
            let alert = UIAlertController(title: "Error!", message: "\(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            return true
        }

        if let error = resultErrors {
            let errorsMessage = error.humanlyReadable()

            let alert = UIAlertController(title: "Error!", message: errorsMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            return true
        }

        return false
    }
}
