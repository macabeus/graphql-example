//
//  ApolloClientShared.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 16/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation
import Apollo

class ApolloSession {
    static let shared = ApolloSession()

    let endpointUrl = URL(string: "http://localhost:4000/api")!
    private var token: String? {
        didSet {
            updateApolloClient()
        }
    }
    private var _userId: Int?
    var userId: Int? {
        return _userId
    }

    var client: ApolloClient!

    private init() {
        updateApolloClient()
    }

    func setNewSession(userId: Int, token: String) {
        self._userId = userId
        self.token = "Bearer \(token)"
    }

    private func updateApolloClient() {
        let network: HTTPNetworkTransport
        if let token = token {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Authorization": token]

            network = HTTPNetworkTransport(url: endpointUrl, configuration: configuration)
        } else {
            network = HTTPNetworkTransport(url: endpointUrl)
        }

        client = ApolloClient(networkTransport: network)
    }
}
