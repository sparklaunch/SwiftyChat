//
//  FirestoreManager.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/25.
//

import UIKit
import Firebase

protocol FirestoreManagerDelegate {
    func didLoadMessages(_ firestoreManager: FirestoreManager, with data: [Message])
}

class FirestoreManager {
    let firestore: Firestore = Firestore.firestore()
    var delegate: FirestoreManagerDelegate?
    func loadMessages() {
        self.firestore.collection("messages").order(by: "date").addSnapshotListener { (querySnapshot, error) in
            if let safeError: Error = error {
                // When there is an error.
                let localizedError: String = safeError.localizedDescription
                print(localizedError)
            }
            else {
                // When there is no error.
                if let safeQuerySnapshot: QuerySnapshot = querySnapshot {
                    // When there is a query snapshot.
                    let documents: [QueryDocumentSnapshot] = safeQuerySnapshot.documents
                    var messages: [Message] = [Message]()
                    for document in documents {
                        let data: [String: Any] = document.data()
                        let username: String = data["username"] as! String
                        let messageText: String = data["messageText"] as! String
                        let date: Double = data["date"] as! Double
                        let newMessage: Message = Message(username: username, messageText: messageText, date: date)
                        messages.append(newMessage)
                    }
                    self.delegate?.didLoadMessages(self, with: messages)
                }
                else {
                    // When no query snapshot is found.
                }
            }
        }
    }
}
