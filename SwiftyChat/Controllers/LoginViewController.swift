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
    var authenticationManager: AuthenticationManager = AuthenticationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.authenticationManager.delegate = self
        self.title = K.loginText
    }
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and the password textfield have inputs.
            let username: String = self.usernameTextField.text!
            let password: String = self.passwordTextField.text!
            self.authenticationManager.signIn(with: username, with: password)
        }
        else {
            // When either one of the username and the password textfield is empty.
            K.showUIAlert(with: K.Errors.fillBothTextfields, on: self)
        }
    }
}

// MARK: - Username and Password TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.usernameTextField.text! != "" && self.passwordTextField.text! != "" {
            // When both the username and password textfield have inputs.
            let username: String = self.usernameTextField.text!
            let password: String = self.passwordTextField.text!
            self.authenticationManager.signIn(with: username, with: password)
            return true
        }
        else {
            // When either one of the username and password textfield is empty.
            K.showUIAlert(with: K.Errors.fillBothTextfields, on: self)
            return false
        }
    }
}

// MARK: - AuthenticationManagerDelegate

extension LoginViewController: AuthenticationManagerDelegate {
    func didAuthenticate(_ authenticationManager: AuthenticationManager, with username: String) {
        let chatViewController: ChatViewController = self.storyboard?.instantiateViewController(identifier: K.chatViewIdentifier) as! ChatViewController
        chatViewController.username = username
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
    func didFailWithError(_ authenticationManager: AuthenticationManager, with localizedError: String) {
        K.showUIAlert(with: localizedError, on: self)
    }
}
