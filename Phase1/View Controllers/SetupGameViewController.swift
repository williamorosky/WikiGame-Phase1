//
//  SetupGameViewController.swift
//  Phase1
//
//  Created by William O'Rosky on 5/17/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit
import Material

class SetupGameViewController: UIViewController, GameTextViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var startGameButton: PressableButton!
    @IBOutlet weak var gameModeLabel: UILabel!
    @IBOutlet weak var startTextView: GameTextView!
    @IBOutlet weak var endTextView: GameTextView!

    //MARK: - Properties
    var gameType = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setupLabel()
        setupButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
    }
    
    func setupLabel() {
        
        if (gameType == 0) {
            gameModeLabel.text = "Mode: Fastest to Goal"
        } else if (gameType == 1) {
            gameModeLabel.text = "Mode: Fewest Taps to Goal"
        }
    }
    
    func setupButton() {
        let buttonColor = UIColor(named: "Purple1") ?? .purple
        let shadowColor = UIColor(named: "Purple2") ?? .purple
        startGameButton.colors = .init(button: buttonColor, shadow: shadowColor)
        startGameButton.shadowHeight = 5
        startGameButton.cornerRadius = 4
        startGameButton.offset = 0.8
    }
    
    func textViewDidChangeHeight(_ textView: GameTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
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

extension SetupGameViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}
