//
//  CreatePostViewController.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 04/11/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewBody: UITextView!
    
    override func viewDidLoad() {
        let buttonAddPost = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddPostTapped))
        navigationItem.rightBarButtonItem = buttonAddPost
    }

    @objc func buttonAddPostTapped() {
        guard let title = textFieldTitle.text else { return }
        guard let body = textViewBody.text else { return }

        PostsRequest.createPost(title: title, body: body) { result in
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
                return
            default: break
            }

            self.navigationController?.popViewController(animated: true)
        }
    }
}
