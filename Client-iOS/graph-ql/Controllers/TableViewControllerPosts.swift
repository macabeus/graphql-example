//
//  TableViewControllerPosts.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 16/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class TableViewControllerPosts: UITableViewController {
    var tableDataSource: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var filterShowOnlyMyPosts = false {
        didSet {
            fetchPosts()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        fetchPosts()
    }

    func fetchPosts() {
        func completion(result: RequestResult<[Post]>) {
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
            case .success(let posts):
                self.tableDataSource = posts
            }
        }

        if filterShowOnlyMyPosts {
            PostsRequest.fetch(userId: ApolloSession.shared.userId, completion: completion)
        } else {
            PostsRequest.fetch(completion: completion)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataSource.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let configCell = tableView.dequeueReusableCell(withIdentifier: "ConfigCell") as? ConfigCell else {
                return UITableViewCell()
            }

            configCell.delegate = self
            return configCell
        }

        let currentPost = tableDataSource[indexPath.section - 1]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell else {
            return UITableViewCell()
        }

        cell.labelTitle.text = currentPost.name
        cell.labelAuthor.text = currentPost.author.name
        cell.labelLikeCount.text = "\(currentPost.countLikes)"
        cell.setLiked(state: currentPost.liked)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let storyboard = self.storyboard,
            let controller = storyboard.instantiateViewController(withIdentifier: "PostDetail") as? PostDetailViewController,
            let navigationController = self.navigationController else {
                return
        }

        controller.currentPost = tableDataSource[indexPath.section - 1]
        navigationController.pushViewController(controller, animated: true)
    }
}

extension TableViewControllerPosts: ConfigCellDelegate {
    func updateShowOnlyMyPosts(filter: Bool) {
        filterShowOnlyMyPosts = filter
    }
}
