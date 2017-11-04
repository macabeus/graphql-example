//
//  PostDetailViewController.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 04/11/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    var currentPost: Post!

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var textViewBody: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = currentPost.name
        labelAuthor.text = currentPost.author.name
        textViewBody.text = currentPost.body
    }
}
