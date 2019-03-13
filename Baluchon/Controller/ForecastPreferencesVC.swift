//
//  ForecastLocationViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 27/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
  func userEnteredNewCityName(top: String, bottom: String)
}

class ForecastPreferencesVC: UIViewController {
  
  @IBOutlet weak var segmentLocationTracker: UISegmentedControl!
  @IBOutlet weak var userTopEntry: UITextField!
  @IBOutlet weak var userBottomEntry: UITextField!
  
  var delegate: ChangeCityDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Swipe gesture to dismiss forecast preferences
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
  
  //TODO: Hide user input when segment location is on "Current Location"
  @IBAction func locationTracker(_ sender: UISegmentedControl) {
    switch segmentLocationTracker.selectedSegmentIndex {
    case 0:
      userTopEntry.isEnabled = false
      userTopEntry.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
    case 1:
      userTopEntry.isEnabled = true
      userTopEntry.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    default:
      break
    }
  }
  
  // User send his cities entry to ForecastVC 
  @IBAction func saveChanges(_ sender: Any) {
    let topCity = userTopEntry.text!.capitalized
    let bottomCity = userBottomEntry.text!.capitalized
    delegate?.userEnteredNewCityName(top: topCity, bottom: bottomCity)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dismissModal(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK: dismiss keyboard
extension ForecastPreferencesVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userTopEntry.resignFirstResponder()
    userBottomEntry.resignFirstResponder()
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
