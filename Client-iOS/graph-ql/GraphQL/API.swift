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

public final class GetPostsQuery: GraphQLQuery {
  public static let operationString =
    "query GetPosts {\n  posts {\n    __typename\n    title\n    body\n  }\n}"

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
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("body", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(title: String? = nil, body: String? = nil) {
        self.init(snapshot: ["__typename": "Post", "title": title, "body": body])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
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
    }
  }
}