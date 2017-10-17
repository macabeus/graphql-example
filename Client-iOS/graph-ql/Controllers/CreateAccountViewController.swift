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

        let mutation = CreateUserMutation(username: username, password: password, name: name)
        ApolloSession.shared.client.perform(mutation: mutation) { result, error in
            if let error = error {
                print(#function, "ERROR | An error occured: \(error)")
                return
            }

            if let error = result?.errors {
                let errorsMessage = error.reduce("") { "\($0)\n\n\($1)" }
                print(errorsMessage)
                return
            }
        }
    }
}
