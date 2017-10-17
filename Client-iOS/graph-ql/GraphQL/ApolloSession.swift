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
    var token: String? {
        didSet {
            updateApolloClient()
        }
    }

    var client: ApolloClient!

    private init() {
        updateApolloClient()
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
