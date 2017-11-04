//  This file was automatically generated and should not be edited.

import Apollo

public final class UserLoginMutation: GraphQLMutation {
  public static let operationString =
    "mutation UserLogin($username: String!, $password: String!) {\n  login(username: $username, password: $password) {\n    __typename\n    token\n  }\n}"

  public var username: String
  public var password: String

  public init(username: String, password: String) {
    self.username = username
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutationType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(login: Login? = nil) {
      self.init(snapshot: ["__typename": "RootMutationType", "login": login.flatMap { $0.snapshot }])
    }

    public var login: Login? {
      get {
        return (snapshot["login"] as? Snapshot).flatMap { Login(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["Session"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(token: String? = nil) {
        self.init(snapshot: ["__typename": "Session", "token": token])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String? {
        get {
          return snapshot["token"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}

public final class CreateUserMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateUser($username: String!, $password: String!, $name: String) {\n  createUser(username: $username, password: $password, name: $name) {\n    __typename\n    id\n  }\n}"

  public var username: String
  public var password: String
  public var name: String?

  public init(username: String, password: String, name: String? = nil) {
    self.username = username
    self.password = password
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutationType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createUser", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password"), "name": GraphQLVariable("name")], type: .object(CreateUser.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createUser: CreateUser? = nil) {
      self.init(snapshot: ["__typename": "RootMutationType", "createUser": createUser.flatMap { $0.snapshot }])
    }

    public var createUser: CreateUser? {
      get {
        return (snapshot["createUser"] as? Snapshot).flatMap { CreateUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil) {
        self.init(snapshot: ["__typename": "User", "id": id])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class GetPostsQuery: GraphQLQuery {
  public static let operationString =
    "query GetPosts {\n  posts {\n    __typename\n    id\n    title\n    body\n    countLikes\n    liked\n    user {\n      __typename\n      name\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootQueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("posts", type: .list(.object(Post.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(posts: [Post?]? = nil) {
      self.init(snapshot: ["__typename": "RootQueryType", "posts": posts.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var posts: [Post?]? {
      get {
        return (snapshot["posts"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Post(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "posts")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes = ["Post"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("body", type: .scalar(String.self)),
        GraphQLField("countLikes", type: .scalar(Int.self)),
        GraphQLField("liked", type: .scalar(Bool.self)),
        GraphQLField("user", type: .object(User.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, title: String? = nil, body: String? = nil, countLikes: Int? = nil, liked: Bool? = nil, user: User? = nil) {
        self.init(snapshot: ["__typename": "Post", "id": id, "title": title, "body": body, "countLikes": countLikes, "liked": liked, "user": user.flatMap { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String? {
        get {
          return snapshot["title"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var body: String? {
        get {
          return snapshot["body"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "body")
        }
      }

      public var countLikes: Int? {
        get {
          return snapshot["countLikes"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "countLikes")
        }
      }

      public var liked: Bool? {
        get {
          return snapshot["liked"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "liked")
        }
      }

      public var user: User? {
        get {
          return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String? = nil) {
          self.init(snapshot: ["__typename": "User", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class CreateLikeMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateLike($postId: Int!) {\n  likePost(postId: $postId) {\n    __typename\n    post {\n      __typename\n      countLikes\n    }\n  }\n}"

  public var postId: Int

  public init(postId: Int) {
    self.postId = postId
  }

  public var variables: GraphQLMap? {
    return ["postId": postId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutationType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("likePost", arguments: ["postId": GraphQLVariable("postId")], type: .object(LikePost.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(likePost: LikePost? = nil) {
      self.init(snapshot: ["__typename": "RootMutationType", "likePost": likePost.flatMap { $0.snapshot }])
    }

    public var likePost: LikePost? {
      get {
        return (snapshot["likePost"] as? Snapshot).flatMap { LikePost(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "likePost")
      }
    }

    public struct LikePost: GraphQLSelectionSet {
      public static let possibleTypes = ["Like"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("post", type: .object(Post.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(post: Post? = nil) {
        self.init(snapshot: ["__typename": "Like", "post": post.flatMap { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var post: Post? {
        get {
          return (snapshot["post"] as? Snapshot).flatMap { Post(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "post")
        }
      }

      public struct Post: GraphQLSelectionSet {
        public static let possibleTypes = ["Post"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("countLikes", type: .scalar(Int.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(countLikes: Int? = nil) {
          self.init(snapshot: ["__typename": "Post", "countLikes": countLikes])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var countLikes: Int? {
          get {
            return snapshot["countLikes"] as? Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "countLikes")
          }
        }
      }
    }
  }
}

public final class DeleteLikeMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteLike($postId: Int!) {\n  dislikePost(postId: $postId) {\n    __typename\n    post {\n      __typename\n      countLikes\n    }\n  }\n}"

  public var postId: Int

  public init(postId: Int) {
    self.postId = postId
  }

  public var variables: GraphQLMap? {
    return ["postId": postId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutationType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("dislikePost", arguments: ["postId": GraphQLVariable("postId")], type: .object(DislikePost.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(dislikePost: DislikePost? = nil) {
      self.init(snapshot: ["__typename": "RootMutationType", "dislikePost": dislikePost.flatMap { $0.snapshot }])
    }

    public var dislikePost: DislikePost? {
      get {
        return (snapshot["dislikePost"] as? Snapshot).flatMap { DislikePost(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "dislikePost")
      }
    }

    public struct DislikePost: GraphQLSelectionSet {
      public static let possibleTypes = ["Like"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("post", type: .object(Post.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(post: Post? = nil) {
        self.init(snapshot: ["__typename": "Like", "post": post.flatMap { $0.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var post: Post? {
        get {
          return (snapshot["post"] as? Snapshot).flatMap { Post(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "post")
        }
      }

      public struct Post: GraphQLSelectionSet {
        public static let possibleTypes = ["Post"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("countLikes", type: .scalar(Int.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(countLikes: Int? = nil) {
          self.init(snapshot: ["__typename": "Post", "countLikes": countLikes])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var countLikes: Int? {
          get {
            return snapshot["countLikes"] as? Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "countLikes")
          }
        }
      }
    }
  }
}