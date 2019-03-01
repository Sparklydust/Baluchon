//
//  TranslatorViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 25/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
  
  
  @IBOutlet weak var topFlag: UIButton!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var userEntry: UITextView!
  @IBOutlet weak var bottomFlag: UIButton!
  @IBOutlet weak var bottomLabel: UILabel!
  @IBOutlet weak var translationOutput: UITextView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = true
    
    // Swipe gesture to move between tab Bar
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    leftSwipe.direction = .left
    rightSwipe.direction = .right
    self.view.addGestureRecognizer(leftSwipe)
    self.view.addGestureRecognizer(rightSwipe)
  }
  
  @IBAction func getTextTranslation(_ sender: UIButton) {
  }
  
  @IBAction func swapLanguage(_ sender: UIButton) {
  }
  

}

//MARK: - Method to swipe between TabBar
extension TranslatorViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .left {
      self.tabBarController!.selectedIndex += 1
      userEntry.resignFirstResponder()
    }
    if sender.direction == .right {
      self.tabBarController!.selectedIndex -= 1
      userEntry.resignFirstResponder()
    }
  }
}

//MARK: - Perform segue to language preferences
extension TranslatorViewController {
  @IBAction func changeTopLanguage(_ sender: UIButton) {
    performSegue(withIdentifier: "goToPreferences", sender: self)
  }
  @IBAction func changeBottomLanguage(_ sender: UIButton) {
    performSegue(withIdentifier: "goToPreferences", sender: self)
  }
}

// MARK: dismiss keyboard
extension TranslatorViewController {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userEntry.resignFirstResponder()
  }
}
