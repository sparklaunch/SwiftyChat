//
//  ChatViewController.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/23.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swifty Chat"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesBackButton = false
    }
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch let error {
            // When the logout failed.
            let localizedError: String = error.localizedDescription
            print(localizedError)
        }
    }
}
