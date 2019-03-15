//
//  TranslatorViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 25/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
  
  var params = [String: String]()
  
  @IBOutlet weak var topFlag: UIButton!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var userEntry: UITextView!
  @IBOutlet weak var swapButton: UIButton!
  @IBOutlet weak var bottomFlag: UIButton!
  @IBOutlet weak var bottomLabel: UILabel!
  @IBOutlet weak var translationOutput: UITextView!
  @IBOutlet weak var translateButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupParamsAtLaunch()
    swapBetweenTabBars()
    userEntry.delegate = self
  }
  
  // Swap the language section between each other
  @IBAction func swapLanguage(_ sender: UIButton) {
    clearTextViews()
    APIsRuler.shared.swapElements(&topLabel.text, &bottomLabel.text)
    APIsRuler.shared.swapElements(&userEntry.text, &translationOutput.text)
    if let topFlagImageView = topFlag.imageView, let bottomFlagImageView = bottomFlag.imageView {
      APIsRuler.shared.swapElements(&topFlagImageView.image, &bottomFlagImageView.image)
    }
  }
}

//MARK: - Delegate of the ChangeLanguage protocol that brings user preferences
extension TranslatorViewController: ChangeLanguageDelegate {
  func userSetLanguages(top: LanguageTuple, bottom: LanguageTuple) {
    self.topFlag.setImage(top.flag, for: .normal)
    self.topLabel.text = top.language
    self.bottomFlag.setImage(bottom.flag, for: .normal)
    self.bottomLabel.text = bottom.language
    clearTextViews()
    
    params = ["source": top.code, "target": bottom.code]
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPreferences" {
      let destinationVC = segue.destination as! TranslatorPreferencesVC
      destinationVC.delegate = self
    }
  }
}

//MARK: - Updating VC or showing off alert when data comes back or not
extension TranslatorViewController {
  // User asks for the translation of his input
  @IBAction func getTranslation(_ sender: UIButton) {
    triggerActivityIndicator(true)
    translationOutput.text! = ""
    APIsRuler.shared.getTranslation(q: userEntry.text!, source: params["source"]!, target: params["target"]!) {
      (success, translationResult) in
      self.triggerActivityIndicator(false)
      self.setTranslationOutputFontBackToNormal()
      if success, let translationResult = translationResult {
        self.updateUserView(with: translationResult)
      }
      else {
        self.presentAlert()
      }
    }
  }
  
  // Update user view when data comes back
  func updateUserView(with translation: TranslationResult) {
    translationOutput.text! = "\(translation)"
  }
  
  // Show alert in case data can not be retrieve from network
  func presentAlert() {
    let alertVC = UIAlertController(title: "Error", message: "Sorry, there was an error loading data", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  
  // Disable buttons and show Activity Indicator if true
  func triggerActivityIndicator(_ action: Bool) {
    translateButton.isHidden = action
    activityIndicator.isHidden = !action
    swapButton.isEnabled = !action
    userEntry.isEditable = !action
    topFlag.isEnabled = !action
    bottomFlag.isEnabled = !action
    userEntry.resignFirstResponder()
  }
  
  func clearTextViews() {
    userEntry.text! = ""
    translationOutput.text! = ""
  }
}

//MARK: - Methods used to swipe between TabBars
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
  
  func swapBetweenTabBars() {
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    leftSwipe.direction = .left
    rightSwipe.direction = .right
    self.view.addGestureRecognizer(leftSwipe)
    self.view.addGestureRecognizer(rightSwipe)
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

//MARK: Dismiss keyboard
extension TranslatorViewController: UITextViewDelegate {
  // Dismiss keyboard by tapping on screen
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userEntry.resignFirstResponder()
  }
  
  //TODO: - Resign keyboard correctly
//  // Dismiss keyboard by tapping the done button
//  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    if (text == "\n") {
//      userEntry.resignFirstResponder()
//      return false
//    }
//    return true
//  }
}

//MARK: - Parameters at first app launch
extension TranslatorViewController {
  func setupParamsAtLaunch() {
    triggerActivityIndicator(false)
    params = ["source": "fr", "target": "en"]
    topFlag.imageView?.image = UIImage(named: "france")
    bottomFlag.imageView?.image = UIImage(named: "united-kingdom")
    topLabel.text! = "French"
    bottomLabel.text! = "English"
    translationOutput.text! = "Enter your text to be translated below the top flag or press on it to change languages."
    translationOutput.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    translationOutput.font = UIFont(name: "HelveticaNeue-Medium", size: 19.5)
  }
  
  func setTranslationOutputFontBackToNormal() {
    self.translationOutput.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    self.translationOutput.font = UIFont(name: "Futura-Bold", size: 16)
  }
}
