//
//  AuthenticationManager.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/24.
//

import UIKit
import Firebase

protocol AuthenticationManagerDelegate {
    func showChatViewController(with username: String)
}

struct AuthenticationManager {
    var delegate: AuthenticationManagerDelegate?
    func signIn(with username: String, with password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if let safeError: Error = error {
                // When the error is not nil (if there is an error).
                let localizedError: String = safeError.localizedDescription
                print(localizedError)
            }
            else {
                // When no error is found.
                self.delegate?.showChatViewController(with: username)
            }
        }
    }
    func signUp(with username: String, with password: String) {
        Auth.auth().createUser(withEmail: username, password: password, completion: { (result, error) in
            if let safeError: Error = error {
                // When it has any error in it.
                let localizedError: String = safeError.localizedDescription
                print(localizedError)
            }
            else {
                // When no error has been found.
                self.delegate?.showChatViewController(with: username)
            }
        })
    }
}
