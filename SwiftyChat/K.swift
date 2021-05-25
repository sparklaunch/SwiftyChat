//
//  K.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/17.
//

import UIKit

struct K {
    static let titleText: String = "⌘ Swifty Chat"
    static let titleAnimationMultiplier: Double = 0.3
    static let loginText: String = "Log In"
    static let registerText: String = "Register"
    static let chatViewIdentifier: String = "Chat"
    static let messageCellNibName: String = "MessageTableViewCell"
    static let messageCellIdentifier: String = "MessageCell"
    static let messageCellHeight: CGFloat = 60
    struct Colors {
        static let titleTextColor: UIColor = UIColor.black
        static func generateRandomColor() -> UIColor {
            let randomR: CGFloat = CGFloat(Float.random(in: 0...1.0))
            let randomG: CGFloat = CGFloat(Float.random(in: 0...1.0))
            let randomB: CGFloat = CGFloat(Float.random(in: 0...1.0))
            let randomColor: UIColor = UIColor(red: randomR, green: randomG, blue: randomB, alpha: 1.0)
            return randomColor
        }
    }
    struct Fire {
        static let collectionName: String = "messages"
        static let dateColumnName: String = "date"
        static let usernameColumnName: String = "username"
        static let messageTextColumnName: String = "messageText"
    }
    struct Errors {
        static let fillBothTextfields: String = "Please fill both textfields"
        static let noQueryFound: String = "No query snapshot was found"
        static let messageTextFieldEmpty: String = "Message textfield must have contents"
    }
    static func showUIAlert(with message: String, on viewController: UIViewController) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
