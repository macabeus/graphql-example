//
//  ConfigCell.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 04/11/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

protocol ConfigCellDelegate {
    func updateShowOnlyMyPosts(filter: Bool)
}

class ConfigCell: UITableViewCell {
    var delegate: ConfigCellDelegate?

    @IBAction func switchShowOnlyMyPostsChanged(_ sender: UISwitch) {
        delegate?.updateShowOnlyMyPosts(filter: sender.isOn)
    }
}
