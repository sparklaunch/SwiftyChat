//
//  ChatViewController.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/23.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    var username: String?
    var messages: [Message] = [Message]()
    let firestoreManager: FirestoreManager = FirestoreManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firestoreManager.delegate = self
        self.messageTextField.delegate = self
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        self.chatTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.title = "Swifty Chat"
        self.firestoreManager.loadMessages()
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
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if self.messageTextField.text! != "" {
            // When the message textfield is not empty.
            let messageText: String = self.messageTextField.text!
            self.sendMessage(messageText)
            self.messageTextField.text! = ""
        }
        else {
            // When the message textfield is empty.
        }
    }
}

// MARK: - Message TextField Delegate

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text! != "" {
            // When the message textfield is not empty.
            let messageText: String = textField.text!
            self.sendMessage(messageText)
            self.messageTextField.text = ""
            return true
        }
        else {
            // When the message textfield is empty.
            return false
        }
    }
    func sendMessage(_ messageText: String) {
        let currentUser: String = Auth.auth().currentUser!.email!
        let date: Double = Date().timeIntervalSince1970
        let database: Firestore = Firestore.firestore()
        let dataDictionary: [String: Any] = [
            "username": currentUser,
            "date": date,
            "messageText": messageText
        ]
        database.collection("messages").addDocument(data: dataDictionary)
    }
}

// MARK: - Message TableView Delegate

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - Message TableView DataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row: Int = indexPath.row
        let message: Message = self.messages[row]
        let messageCell: MessageTableViewCell = self.chatTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        messageCell.messageLabel.text = message.messageText
        messageCell.othersIcon.isHidden = false
        messageCell.meIcon.isHidden = false
        if message.username == Auth.auth().currentUser?.email {
            // If the message sender and the current username match.
            messageCell.othersIcon.isHidden = true
            messageCell.messageLabel.textAlignment = .left
        }
        else {
            // If the message sender and the current username don't match.
            messageCell.meIcon.isHidden = true
            messageCell.messageLabel.textAlignment = .right
        }
        return messageCell
    }
}

// MARK: - FirestoreManagerDelegate

extension ChatViewController: FirestoreManagerDelegate {
    func didLoadMessages(_ firestoreManager: FirestoreManager, with data: [Message]) {
        self.messages = data
        DispatchQueue.main.async {
            self.chatTableView.reloadData()
            let indexPath: IndexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
