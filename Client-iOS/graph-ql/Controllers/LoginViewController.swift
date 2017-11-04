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
        //guard let username = textFieldUserName.text else { return }
        //guard let password = textFieldPassword.text else { return }
        let username = "macabeus"
        let password = "macabeus"

        UsersRequest.login(username: username, password: password) { result in
            switch result {
            case .error(let requestError):
                self.showAlertError(requestError)
            case .success(let token):
                ApolloSession.shared.setNewSession(token: token)
                self.performSegue(withIdentifier: "Posts View", sender: sender)
            }
        }
    }
}
