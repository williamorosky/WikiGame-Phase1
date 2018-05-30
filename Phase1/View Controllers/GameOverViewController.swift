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
    @IBOutlet weak var playAgainButton: PressableButton!
    
    // MARK: - Actions
    @IBAction func playAgain(_ sender: AnyObject) {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }

    //MARK: - Properties
    var gameType = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonColor = UIColor(named: "Purple1") ?? .purple
        let shadowColor = UIColor(named: "Purple2") ?? .purple
        playAgainButton.colors = .init(button: buttonColor, shadow: shadowColor)
        playAgainButton.shadowHeight = 5
        playAgainButton.cornerRadius = 4
        playAgainButton.offset = 0.8
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
