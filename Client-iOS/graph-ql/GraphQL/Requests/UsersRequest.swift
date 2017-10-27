//
//  UsersRequest.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 27/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

class UsersRequest {
    private init() {}

    static func create(username: String, password: String, name: String?, completion: @escaping (RequestResult<()>) -> Void) {
        let mutation = CreateUserMutation(username: username, password: password, name: name)

        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            completion(.success(()))
        }
    }

    static func login(username: String, password: String, completion: @escaping (RequestResult<String>) -> Void) {
        let mutation = UserLoginMutation(username: username, password: password)

        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let token = result?.data?.login?.token else {
                completion(.error(.withoutData))
                return
            }

            completion(.success(token))
        }
    }
}
