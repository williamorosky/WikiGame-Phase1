//
//  GameModeViewController.swift
//  Phase1
//
//  Created by William O'Rosky on 5/16/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit
import Material

class GameModeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var timeBasedButton: PressableButton!
    @IBOutlet weak var tapBasedButton: PressableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let timeBasedButtonColor = UIColor(named: "Green1") ?? .green
        let timeBasedShadowColor = UIColor(named: "Green2") ?? .green
        timeBasedButton.colors = .init(button: timeBasedButtonColor, shadow: timeBasedShadowColor)
        timeBasedButton.shadowHeight = 5
        timeBasedButton.cornerRadius = 4
        timeBasedButton.offset = 0.8
        
        let tapBasedButtonColor = UIColor(named: "Blue1") ?? .blue
        let tapBasedShadowColor = UIColor(named: "Blue2") ?? .blue
        tapBasedButton.colors = .init(button: tapBasedButtonColor, shadow: tapBasedShadowColor)
        tapBasedButton.shadowHeight = 5
        tapBasedButton.cornerRadius = 4
        tapBasedButton.offset = 0.8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if let destination = segue.destination as? SetupGameViewController {
            if (segue.identifier == "timeBasedGame") {
                destination.gameType = 0
            } else if (segue.identifier == "tapBasedGame") {
                destination.gameType = 1
            }
        }
    }
 }

extension GameModeViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}
