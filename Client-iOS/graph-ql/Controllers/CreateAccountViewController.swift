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
            if self.showAlertErrorIfHave(resultErrors: result?.errors, error: error) { return }

            let loginMutation = UserLoginMutation(username: username, password: password)
            ApolloSession.shared.client.perform(mutation: loginMutation) { result, error in
                if let error = error {
                    let alert = UIAlertController(title: "Error!", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
                    return
                }

                if let error = result?.errors {
                    let errorsMessage = error.humanlyReadable()

                    let alert = UIAlertController(title: "Error!", message: errorsMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
                    return
                }

                guard let token = result?.data?.login?.token else {
                    print(#function, "ERROR | Could not retrieve token")
                    return
                }

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
