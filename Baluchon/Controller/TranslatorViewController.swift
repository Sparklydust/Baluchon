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
  
  var apisRuler = APIsRuler()
  
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
  
  //TODO: Swap flag
  // Swap the language section between each other
  @IBAction func swapLanguage(_ sender: UIButton) {
    apisRuler.swapElements(&topLabel.text, &bottomLabel.text)
    apisRuler.swapElements(&userEntry.text, &translationOutput.text)
  }
}

//MARK: - Method to swipe between TabBars
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

//MARK: dismiss keyboard
extension TranslatorViewController {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userEntry.resignFirstResponder()
  }
}

//MARK: - Delegate of the ChangeLanguage protocol
extension TranslatorViewController: ChangeLanguageDelegate {
  func userSetLanguages(top: LanguageTuple, bottom: LanguageTuple) {
    self.topFlag.setImage(top.flag, for: .normal)
    self.topLabel.text = top.language
    self.bottomFlag.setImage(bottom.flag, for: .normal)
    self.bottomLabel.text = bottom.language
    
    // TODO: Call the api with a function here to get the Language translator
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPreferences" {
      let destinationVC = segue.destination as! TranslatorPreferencesVC
      destinationVC.delegate = self
    }
  }
}
