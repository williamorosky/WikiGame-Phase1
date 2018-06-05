//
//  GameOverViewController.swift
//  Phase1
//
//  Created by William O'Rosky on 5/30/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gameModeValueLabel: UILabel!
    @IBOutlet weak var pathView: PathView!
    @IBOutlet weak var playAgainButton: PressableButton!
    
    // MARK: - Actions
    @IBAction func playAgain(_ sender: AnyObject) {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }

    //MARK: - Properties
    var gameType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 4
        
        pathView.titles = ["The Election of 1800", "Thomas Jefferson", "Really Long Title to Test Word Wrap", "Eiffel Tower", "Tower", "Burj Khalifa", "Syria", "ISIS"]

        let buttonColor = UIColor(named: "Purple1") ?? .purple
        let shadowColor = UIColor(named: "Purple2") ?? .purple
        playAgainButton.colors = .init(button: buttonColor, shadow: shadowColor)
        playAgainButton.shadowHeight = 5
        playAgainButton.cornerRadius = 4
        playAgainButton.bottomOnly = true
        playAgainButton.offset = 0.8
        
        if gameType == 0 {
            gameModeValueLabel.text = "Time Elapsed - 00:00"
        } else if gameType == 1 {
            gameModeValueLabel.text = "Total Taps - 6"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameOverViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}
