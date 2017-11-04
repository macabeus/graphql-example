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
    @IBOutlet weak var imageLike: UIImageView!
    @IBOutlet weak var labelLikeCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPostInfos()

        let gestureTapLike = UITapGestureRecognizer(target: self, action: #selector(sendLike))
        imageLike.addGestureRecognizer(gestureTapLike)
    }

    func setPostInfos() {
        labelTitle.text = currentPost.name
        labelAuthor.text = currentPost.author.name
        textViewBody.text = currentPost.body

        labelLikeCount.text = "\(currentPost.countLikes)"

        imageLike.image = imageLike.image?.withRenderingMode(.alwaysTemplate)
        if currentPost.liked {
            imageLike.tintColor = .blue
        } else {
            imageLike.tintColor = .black
        }
    }

    @objc func sendLike() {
        func completion(liked: Bool, result: RequestResult<Int>) {
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
            case .success(let countLikes):
                self.currentPost.countLikes = countLikes
                self.currentPost.liked = liked

                self.setPostInfos()
            }
        }

        if currentPost.liked {
            PostsRequest.DeleteLike(post: currentPost) { result in
                completion(liked: false, result: result)
            }
        } else {
            PostsRequest.CreateLike(post: currentPost) { result in
                completion(liked: true, result: result)
            }
        }
    }
}
