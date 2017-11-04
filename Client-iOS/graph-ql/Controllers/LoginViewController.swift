//
//  LoginViewController.swift
//  graph-ql
//
//  Created by Bruno Macabeus Aquino on 16/10/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func buttonLogin(_ sender: Any) {
        guard let username = textFieldUserName.text else { return }
        guard let password = textFieldPassword.text else { return }

        UsersRequest.login(username: username, password: password) { result in
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
            case .success(let userId, let token):
                ApolloSession.shared.setNewSession(userId: userId, token: token)
                self.performSegue(withIdentifier: "Posts View", sender: sender)
            }
        }
    }
}
