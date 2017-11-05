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

    static func fetch(userId: Int? = nil, completion: @escaping (RequestResult<[Post]>) -> Void) {
        let query = GetPostsQuery(userId: userId)

        ApolloSession.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let posts = result?.data?.posts else {
                completion(.error(.withoutData))
                return
            }

            let postsStruct = posts.flatMap { post -> Post? in
                guard let idString = post?.id, let id = Int(idString) else { return nil }

                return Post(
                    id: id,
                    name: post?.title ?? "No title",
                    body: post?.body ?? "",
                    countLikes: post?.countLikes ?? 0,
                    liked: post?.liked ?? false,
                    author: User(
                        name: post?.user?.name ?? "Unkown"
                    )
                )
            }

            completion(.success(postsStruct))
        }
    }

    static func createPost(title: String, body: String, completion: @escaping (RequestResult<Int>) -> Void) {
        let mutation = CreatePostMutation(title: title, body: body)

        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let postIdString = result?.data?.createPost?.id,
                let postId = Int(postIdString) else {
                completion(.error(.withoutData))
                return
            }

            completion(.success(postId))
        }
    }

    static func CreateLike(post: Post, completion: @escaping (RequestResult<Int>) -> Void) {
        let mutation = CreateLikeMutation(postId: post.id)

        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let countLikes = result?.data?.likePost?.post?.countLikes else {
                completion(.error(.withoutData))
                return
            }

            completion(.success(countLikes))
        }
    }

    static func DeleteLike(post: Post, completion: @escaping (RequestResult<Int>) -> Void) {
        let mutation = DeleteLikeMutation(postId: post.id)

        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let countLikes = result?.data?.dislikePost?.post?.countLikes else {
                completion(.error(.withoutData))
                return
            }

            completion(.success(countLikes))
        }
    }
}
