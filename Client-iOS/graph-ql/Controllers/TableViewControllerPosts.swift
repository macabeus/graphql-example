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
        let currentValue = tableDataSource[indexPath.section]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell else {
            return UITableViewCell()
        }

        cell.labelTitle.text = currentValue.name

        return cell
    }
}
