//
//  PostsRequest.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 26/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

class PostsRequest {
    private init() {}

    static func fetch(completion: @escaping (RequestResult<[Post]>) -> Void) {
        let query = GetPostsQuery()

        ApolloSession.shared.client.fetch(query: query) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let posts = result?.data?.posts else {
                completion(.error(.withoutData))
                return
            }

            let postsStruct = posts.map {
                Post(
                    name: $0?.title ?? "No title",
                    body: $0?.body ?? "",
                    countLikes: $0?.countLikes ?? 0,
                    liked: $0?.liked ?? false,
                    author: User(
                        name: $0?.user?.name ?? "Unkown"
                    )
                )
            }

            completion(.success(postsStruct))
        }
    }
}
