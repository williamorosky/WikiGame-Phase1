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
    @IBOutlet weak var startSuggestion: UIButton!
    @IBOutlet weak var endSuggestion: UIButton!
    
    
    // MARK: - Actions
    @IBAction func startFillSuggestion(_ sender: AnyObject) {
        if let button = sender as? UIButton {
            startTextView.text = button.titleLabel?.text
            startTextView.needsNewFontSize()
            startTextView.setNeedsLayout()
            startTextView.setNeedsDisplay()
            startTextView.layoutIfNeeded()
            startTextView.needsNewFontSize()
            startTextView.setNeedsLayout()
            startTextView.setNeedsDisplay()
            startTextView.layoutIfNeeded()
            startTextView.resignFirstResponder()
            
            endTextView.text = button.titleLabel?.text
            endTextView.needsNewFontSize()
            endTextView.setNeedsLayout()
            endTextView.setNeedsDisplay()
            endTextView.layoutIfNeeded()
            endTextView.needsNewFontSize()
            endTextView.setNeedsLayout()
            endTextView.setNeedsDisplay()
            endTextView.layoutIfNeeded()
            endTextView.resignFirstResponder()
        }
    }
    
    @IBAction func endFillSuggestion(_ sender: AnyObject) {
        if let button = sender as? UIButton {
            endTextView.text = button.titleLabel?.text
            endTextView.needsNewFontSize()
            endTextView.setNeedsLayout()
            endTextView.resignFirstResponder()
        }
    }
    
    //MARK: - Properties
    var gameType = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        startTextView.delegate = self
        startTextView.tag = 0
        endTextView.delegate = self
        endTextView.tag = 1

        setupLabel()
        setupButtons()
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
    
    func setupButtons() {
        
        startSuggestion.contentHorizontalAlignment = .left
        endSuggestion.contentHorizontalAlignment = .left

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
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 2 {
            APIHandler.getAutofillSuggestion(text: textView.text)
                .done { suggestions -> Void in
                    if textView.tag == 0 {
                        if suggestions.count > 0 {
                            self.setSuggestionText("start", suggestion: suggestions[0])
                        } else {
                            self.setSuggestionText("start", suggestion: "")
                        }
                    } else if textView.tag == 1 {
                        if suggestions.count > 0 {
                            self.setSuggestionText("end", suggestion: suggestions[0])
                        } else {
                            self.setSuggestionText("end", suggestion: "")
                        }
                    }
                }
                .catch { error in
                    //Handle error or give feedback to the user
                    print(error.localizedDescription)
            }
        } else {
            if textView.tag == 0 {
                self.setSuggestionText("start", suggestion: "")
            } else if textView.tag == 1 {
                self.setSuggestionText("end", suggestion: "")
            }
        }
    }
    
    func setSuggestionText(_ endpoint:String, suggestion:String) {
        if endpoint == "start" {
            startSuggestion.setTitle(suggestion, for: .normal)
        } else if endpoint == "end" {
            endSuggestion.setTitle(suggestion, for: .normal)
        }
    }

    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier, ident == "startGame" {
//            guard endpointsAreValid() else {
//                return false
//            }
            
            return true
        }
        return false
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if let destination = segue.destination as? GameViewController {
            if (segue.identifier == "startGame") {
                destination.gameType = self.gameType
//                APIHandler.getPath(startTextView.text, end: endTextView.text)
//                    .done { json -> Void in
//                        //Do something with the JSON info
//                        print(json)
//                    }
//                    .catch { error in
//                        //Handle error or give feedback to the user
//                        print(error.localizedDescription)
//                }
                
                destination.navigationItem.setHidesBackButton(true, animated:false)
            }
        }
    }

    func endpointsAreValid() -> Bool {
        if startTextView.text == startSuggestion.titleLabel?.text &&
            endTextView.text == endSuggestion.titleLabel?.text {
            //check if path exists
            return true
        }
        return false
    }

}

extension SetupGameViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}
