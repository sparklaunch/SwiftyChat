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
    var authenticationManager: AuthenticationManager = AuthenticationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authenticationManager = AuthenticationManager()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.authenticationManager.delegate = self
        self.title = "Register"
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and the password textfield have inputs.
            let username: String = self.usernameTextField.text!
            let password: String = self.passwordTextField.text!
            self.register(with: username, with: password)
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
            let username: String = self.usernameTextField.text!
            let password: String = self.passwordTextField.text!
            self.register(with: username, with: password)
            return true
        }
        else {
            // When either one of the textfields is empty.
            return false
        }
    }
    func register(with username: String, with password: String) {
        self.authenticationManager.signUp(with: username, with: password)
    }
}

// MARK: - AuthenticationManagerDelegate

extension RegisterViewController: AuthenticationManagerDelegate {
    func didAuthenticate(_ authenticationManager: AuthenticationManager, with username: String) {
        let chatViewController: ChatViewController = self.storyboard?.instantiateViewController(identifier: "Chat") as! ChatViewController
        chatViewController.username = username
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}
