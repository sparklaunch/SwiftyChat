//
//  ChatViewController.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/23.
//

import UIKit

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
}
