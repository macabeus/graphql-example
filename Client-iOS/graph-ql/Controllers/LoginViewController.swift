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
        guard let userName = textFieldUserName.text else { return }
        guard let password = textFieldPassword.text else { return }

        let loginMutation = UserLoginMutation(username: userName, password: password)
        ApolloSession.shared.client.perform(mutation: loginMutation) { result, error in
            if let error = error {
                print(#function, "ERROR | An error occured: \(error)")
                return
            }

            if let error = result?.errors {
                let errorsMessage = error.reduce("") { "\($0)\n\n\($1)" }
                print(errorsMessage)
            }

            guard let token = result?.data?.login?.token else {
                print(#function, "ERROR | Could not retrieve token")
                return
            }

            ApolloSession.shared.setNewSession(token: token)
            self.performSegue(withIdentifier: "Posts View", sender: sender)
        }
    }
}
