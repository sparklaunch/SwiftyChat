//
//  ViewController.swift
//  SwiftyChat
//
//  Created by Jinwook Kim on 2021/05/17.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animateTitleText()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Title Label Animation

extension WelcomeViewController {
    func animateTitleText() {
        self.titleLabel.text = ""
        let multiplier: Double = K.titleAnimationMultiplier
        let titleText: String = K.titleText
        let letters: [String] = titleText.map{String($0)}
        let titleTextCount: Int = titleText.count
        for index in 0..<titleTextCount {
            Timer.scheduledTimer(withTimeInterval: multiplier * Double(index), repeats: false) { Timer in
                self.titleLabel.text?.append(letters[index])
                if index == titleTextCount - 1 {
                    self.titleLabel.textColor = K.Colors.titleTextColor
                }
                else {
                    self.titleLabel.textColor = K.Colors.generateRandomColor()
                }
            }
        }
    }
}
