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
}

// MARK: - Title Label Animation

extension WelcomeViewController {
    func animateTitleText() {
        self.titleLabel.text = ""
        let multiplier: Double = 0.3
        let titleText: String = K.titleText
        let letters: [String] = titleText.map{String($0)}
        let titleTextCount: Int = titleText.count
        for index in 0..<titleTextCount {
            Timer.scheduledTimer(withTimeInterval: multiplier * Double(index), repeats: false) { Timer in
                self.titleLabel.text?.append(letters[index])
                if index == titleTextCount - 1 {
                    self.titleLabel.textColor = UIColor.black
                }
                else {
                    self.titleLabel.textColor = self.generateRandomColor()
                }
            }
        }
    }
    func generateRandomColor() -> UIColor {
        let randomR: CGFloat = CGFloat(Float.random(in: 0...1.0))
        let randomG: CGFloat = CGFloat(Float.random(in: 0...1.0))
        let randomB: CGFloat = CGFloat(Float.random(in: 0...1.0))
        let randomColor: UIColor = UIColor(red: randomR, green: randomG, blue: randomB, alpha: 1.0)
        return randomColor
    }
}
