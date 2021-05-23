//
//  RegisterViewController.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.title = "Register"
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and the password textfield have inputs.
            self.register()
        }
        else {
            // When either one of the username and the password textfield is empty.
        }
    }
}

// MARK: - Username and Password TextField Delegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and password textfield have inputs.
            self.register()
            return true
        }
        else {
            // When either one of the textfields is empty.
            return false
        }
    }
    func register() {
        let username: String = self.usernameTextField.text!
        let password: String = self.passwordTextField.text!
        Auth.auth().createUser(withEmail: username, password: password, completion: { (result, error) in
            if let safeError: Error = error {
                // When it has any error in it.
                let localizedError: String = safeError.localizedDescription
                print(localizedError)
            }
            else {
                // When no error has been found.
                let chatViewController: ChatViewController = self.storyboard?.instantiateViewController(identifier: "Chat") as! ChatViewController
                chatViewController.username = username
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        })
    }
}
