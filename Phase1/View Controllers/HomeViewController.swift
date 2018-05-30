//
//  HomeViewController.swift
//  Phase1
//
//  Created by William O'Rosky on 5/16/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit
import Material

class HomeViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var newGameButton: PressableButton!
    
    // MARK: - Actions
    @IBAction func unwindToHomeViewController(segue:UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonColor = UIColor(named: "Purple1") ?? .purple
        let shadowColor = UIColor(named: "Purple2") ?? .purple
        newGameButton.colors = .init(button: buttonColor, shadow: shadowColor)
        newGameButton.shadowHeight = 5
        newGameButton.cornerRadius = 4
        newGameButton.offset = 0.8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
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

extension HomeViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
}

