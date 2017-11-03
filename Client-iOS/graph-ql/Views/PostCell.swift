//
//  PostCell.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 19/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelLikeCount: UILabel!
    @IBOutlet weak var imageLike: UIImageView!

    override func awakeFromNib() {
        imageLike.image = imageLike.image?.withRenderingMode(.alwaysTemplate)
    }

    func setLiked(state: Bool) {
        if state {
            imageLike.tintColor = .blue
        } else {
            imageLike.tintColor = .black
        }
    }
}
