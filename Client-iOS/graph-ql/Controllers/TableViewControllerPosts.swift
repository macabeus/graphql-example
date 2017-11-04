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

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
    }

    func fetchPosts() {
        PostsRequest.fetch { result in
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
            case .success(let posts):
                self.tableDataSource = posts
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = tableDataSource[indexPath.section]

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

        controller.currentPost = tableDataSource[indexPath.section]
        navigationController.pushViewController(controller, animated: true)
    }
}
