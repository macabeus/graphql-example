//
//  PostsRequestsTests.swift
//  graph-qlTests
//
//  Created by Bruno Macabeus Aquino on 22/11/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import XCTest
@testable import Apollo

class PostsRequestsTests: XCTestCase {

    func testFetch() throws {
        let query = GetPostsQuery(userId: 1)
        let response = GraphQLResponse(operation: query, body: [
            "data": [
                "posts": [
                    [
                        "__typename": "RootQueryType",
                        "id": 1,
                        "title": "title post",
                        "body": "body post",
                        "countLikes": 1,
                        "liked": false,
                        "user": [
                            "__typename": "RootQueryType",
                            "name": "macabeus"
                        ]
                    ]
                ]
            ]
        ])

        let (result, _) = try response.parseResult().await()
        guard let postsRaw = result.data?.posts else { return XCTFail() }
        let posts = PostsRequest.fetchParse(posts: postsRaw)

        XCTAssertEqual(posts.count, 1)

        let postFirst = posts[0]
        XCTAssertEqual(postFirst.name, "title post")
        XCTAssertEqual(postFirst.body, "body post")
        XCTAssertEqual(postFirst.countLikes, 1)
        XCTAssertEqual(postFirst.liked, false)
        XCTAssertEqual(postFirst.author.name, "macabeus")
    }
}
