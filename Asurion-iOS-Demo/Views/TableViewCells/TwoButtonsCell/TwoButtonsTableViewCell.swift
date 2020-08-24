//
//  TwoButtonsTableViewCell.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/24/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import UIKit

class TwoButtonsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Listeners
    var chatButtonPushed: ((UIButton) -> Void)?
    var callButtonPushed: ((UIButton) -> Void)?
    
    // MARK: - Variables
    let chatButton = UIButton()
    let callButton = UIButton()
    
    var isChatEnabled: Bool = false {
        didSet {
            checkAndSetButtons()
        }
    }
    
    var isCallEnabled: Bool = false {
        didSet {
            checkAndSetButtons()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Set Buttons
        self.callButton.backgroundColor = .green
        self.callButton.setTitleColor(.white, for: .normal)
        self.chatButton.setTitleColor(.white, for: .normal)
        self.chatButton.backgroundColor = .blue
        
        self.callButton.setTitle("Call", for: .normal)
        self.chatButton.setTitle("Chat", for: .normal)
        
        self.chatButton.layer.cornerRadius = 10
        self.callButton.layer.cornerRadius = 10
        
        // Vary for Device size
        if traitCollection.isIpad {
            self.callButton.titleLabel?.font = .systemFont(ofSize: 30.0)
            self.chatButton.titleLabel?.font = .systemFont(ofSize: 30.0)
        } else {
            self.callButton.titleLabel?.font = .systemFont(ofSize: 20.0)
            self.chatButton.titleLabel?.font = .systemFont(ofSize: 20.0)
        }
        
        // Detect Touches
        self.chatButton.addTarget(self, action: #selector(TwoButtonsTableViewCell.chatButtonTouchInside(_:)), for: .touchUpInside)
        self.callButton.addTarget(self, action: #selector(TwoButtonsTableViewCell.callButtonTouchInside(_:)), for: .touchUpInside)
        checkAndSetButtons()
    }
    
    // MARK: - Button OBJC Methods
    @objc func chatButtonTouchInside(_ sender: UIButton) {
        self.chatButtonPushed?(sender)
    }
    
    @objc func callButtonTouchInside(_ sender: UIButton) {
        self.callButtonPushed?(sender)
    }
    
    // MARK: - Class Methods
    func checkAndSetButtons() {
        guard stackView != nil else {return}
        if isCallEnabled && !stackView.subviews.contains(self.callButton) {
            stackView.addArrangedSubview(self.callButton)
        } else if !isCallEnabled {
            self.callButton.removeFromSuperview()
        }
        
        if (isChatEnabled && !stackView.subviews.contains(self.chatButton)) {
            self.stackView.addArrangedSubview(chatButton)
        } else if !isChatEnabled {
            self.chatButton.removeFromSuperview()
        }
    }
    
}
