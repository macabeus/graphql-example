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

    // MARK: Fetch
    static func fetch(userId: Int? = nil, completion: @escaping (RequestResult<[Post]>) -> Void) {
        let query = GetPostsQuery(userId: userId)

        ApolloSession.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let postsRaw = result?.data?.posts else {
                completion(.error(.withoutData))
                return
            }

            let posts = fetchParse(posts: postsRaw)

            completion(.success(posts))
        }
    }

    static func fetchParse(posts: [GetPostsQuery.Data.Post?]) -> [Post] {
        return posts.flatMap { post -> Post? in
            return Post(
                id: post?.id,
                name: post?.title,
                body: post?.body,
                countLikes: post?.countLikes,
                liked: post?.liked,
                author: User(
                    name: post?.user?.name
                )
            )
        }
    }

    // MARK: Create post
    static func createPost(title: String, body: String, completion: @escaping (RequestResult<Int>) -> Void) {
        let mutation = CreatePostMutation(title: title, body: body)

        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let requestError = RequestError.check(resultErrors: result?.errors, error: error) {
                completion(.error(requestError))
                return
            }

            guard let postId = result?.data?.createPost?.id else {
                completion(.error(.withoutData))
                return
            }

            completion(.success(postId))
        }
    }

    // MARK: Create like
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

    // MARK: Delete Like
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
