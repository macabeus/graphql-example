//
//  CreateAccountViewController.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 17/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBAction func buttonCreateAccount(_ sender: Any) {
        guard let username = textFieldUsername.text else { return }
        guard let password = textFieldPassword.text else { return }
        let name = textFieldName.text

        UsersRequest.create(username: username, password: password, name: name) { result in
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
                return
            default: break
            }

            UsersRequest.login(username: username, password: password) { result in
                switch result {
                case .error(let requestError):
                    self.showAlertError(requestError)
                case .success(let token):
                    ApolloSession.shared.setNewSession(token: token)

                    guard let loginViewController = self.presentingViewController as? LoginViewController else {
                        let alert = UIAlertController(title: "Success", message: "Your account was create with success", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))

                        self.present(alert, animated: true, completion: nil)

                        return
                    }

                    self.dismiss(animated: true) {
                        loginViewController.performSegue(withIdentifier: "Posts View", sender: sender)
                    }
                }
            }
        }
    }
}
