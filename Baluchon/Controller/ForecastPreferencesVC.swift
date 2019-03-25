//
//  ForecastLocationViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 27/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
  func userEnteredNewCityName(_ name: String)
}

class ForecastPreferencesVC: UIViewController {

  @IBOutlet weak var userBottomEntry: UITextField!

  let defaults = UserDefaults.standard
  static let cityKey = "bottomCityChoice"
  var delegate: ChangeCityDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    swapDownToCancelView()
    userBottomEntry.delegate = self
    if let userSavedCity = defaults.string(
      forKey: ForecastPreferencesVC.cityKey) {
      userBottomEntry.text! = userSavedCity
    }
  }

  // User send his cities entry to ForecastVC 
  @IBAction func saveChanges(_ sender: Any) {
    let bottomCity = userBottomEntry.text!.capitalized
    delegate?.userEnteredNewCityName(bottomCity)
    defaults.set(userBottomEntry.text!,
                 forKey: ForecastPreferencesVC.cityKey)
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func dismissModal(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK: Dismiss keyboard
extension ForecastPreferencesVC: UITextFieldDelegate {
  // Dismiss keyboard by tapping on screen
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userBottomEntry.resignFirstResponder()
  }

  // Dismiss keyboard by tapping the done button
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
}

//MARK: - Method to dismiss view by swiping down
extension ForecastPreferencesVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
}

//MARK: - Swipe Down to cancel view
extension ForecastPreferencesVC {
  func swapDownToCancelView() {
    let swipeToCancel = UISwipeGestureRecognizer(
      target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
}
