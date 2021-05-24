//
//  MessageTableViewCell.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/24.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet var meIcon: UIImageView!
    @IBOutlet var othersIcon: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    var messageText: String?
    var username: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageLabel.text = self.messageText!
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
