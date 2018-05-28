//
//  PauseView.swift
//  Phase1
//
//  Created by William O'Rosky on 5/26/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit

class PauseView: UIView {
    
    //MARK: Outlets
    @IBOutlet weak var pauseButton: PressableButton!

    
    
    // Initialize
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        //contentMode = .redraw
        let pauseButtonColor = UIColor(named: "Red1") ?? .blue
        let pauseButtonShadowColor = UIColor(named: "Red2") ?? .blue
        pauseButton.colors = .init(button: .blue, shadow: .blue)
        pauseButton.shadowHeight = 5
        pauseButton.cornerRadius = 4
        pauseButton.offset = 0.8
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
