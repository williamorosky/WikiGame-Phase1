//
//  PauseView.swift
//  Phase1
//
//  Created by William O'Rosky on 5/30/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit

class PauseView: UIView {
    
    //MARK: Outlets
    @IBOutlet weak var giveUpButton: PressableButton!
    @IBOutlet weak var cancelButton: PressableButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    init() {
        super.init(frame: .zero)
        fromNib()
    }
    
    func setupButtons() {
        let buttonColor = UIColor(named: "Purple1") ?? .purple
        let shadowColor = UIColor(named: "Purple2") ?? .purple
        giveUpButton.colors = .init(button: buttonColor, shadow: shadowColor)
        giveUpButton.shadowHeight = 5
        giveUpButton.cornerRadius = 4
        giveUpButton.offset = 0.8
        
        cancelButton.colors = .init(button: buttonColor, shadow: shadowColor)
        cancelButton.shadowHeight = 5
        cancelButton.cornerRadius = 4
        cancelButton.offset = 0.8
    }

}
