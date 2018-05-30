//
//  GameViewController.swift
//  Phase1
//
//  Created by William O'Rosky on 5/24/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit
import Material
import SwiftEntryKit

class GameViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var gameModeValueLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func pauseGame(_ sender: AnyObject) {
        if let _ = sender as? UIButton {
            var attributes = EKAttributes.centerFloat
            attributes.hapticFeedbackType = .success
            attributes.displayDuration = .infinity
            attributes.screenBackground = .color(color: UIColor.black.withAlphaComponent(0.4))
            attributes.entryBackground = .clear
            attributes.entryInteraction = .absorbTouches
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
            attributes.screenInteraction = .dismiss
            attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            attributes.roundCorners = .all(radius: 3)
            attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                                 scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
            attributes.exitAnimation = .init(translate: .init(duration: 0.2))
            attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
            attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
            attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.minEdge), height: .intrinsic)
            attributes.statusBar = .dark
            showPauseView(attributes: attributes)
        }
    }
    
    //MARK: - Properties
    var gameType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.layer.cornerRadius = 3
        
        if (gameType == 0) {
            gameModeValueLabel.text = "00:00"
        } else if (gameType == 1) {
            gameModeValueLabel.text = "0 Taps"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if (segue.identifier == "GameOver") {
            if let destination = segue.destination as? GameOverViewController {
                destination.gameType = self.gameType
                destination.navigationItem.setHidesBackButton(true, animated:false)
            }
        
        }
    }
    
    // Bumps a custom nib view
    private func showPauseView(attributes: EKAttributes) {
        let pauseView = PauseView()
        pauseView.setupButtons()
        pauseView.giveUpButton.addTarget(self, action: #selector(showGameOverViewController), for: .touchUpInside)
        pauseView.cancelButton.addTarget(self, action: #selector(dismissPauseView), for: .touchUpInside)
        SwiftEntryKit.display(entry: pauseView, using: attributes)
    }
    
    @objc func dismissPauseView() {
        SwiftEntryKit.dismiss()
    }
    
    @objc func showGameOverViewController() {
        SwiftEntryKit.dismiss()
        self.performSegue(withIdentifier: "GameOver", sender: self)
    }
}

extension GameViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}

