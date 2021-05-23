//
//  LoginViewController.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/17.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.title = "Log In"
    }
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and the password textfield have inputs.
            self.signIn()
        }
        else {
            // When either one of the username and the password textfield is empty.
        }
    }
}

// MARK: - Username and Password TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and password textfield have inputs.
            self.signIn()
            return true
        }
        else {
            // When either one of the username and password textfield is empty.
            return false
        }
    }
    func signIn() {
        let username: String = self.usernameTextField.text!
        let password: String = self.passwordTextField.text!
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if let safeError: Error = error {
                // When the error is not nil (if there is an error).
                let localizedError: String = safeError.localizedDescription
                print(localizedError)
            }
            else {
                // When no error is found.
                let chatViewController: ChatViewController = self.storyboard?.instantiateViewController(identifier: "Chat") as! ChatViewController
                chatViewController.username = username
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
    }
}
