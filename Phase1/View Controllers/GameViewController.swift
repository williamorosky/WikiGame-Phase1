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
            let pauseView = PauseView()
//            pauseView.pauseButton.
            var attributes = EKAttributes()
            SwiftEntryKit.display(entry: pauseView, using: attributes)
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
    }
    
}

extension GameViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}

