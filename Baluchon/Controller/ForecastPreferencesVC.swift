//
//  ForecastLocationViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 27/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ForecastPreferencesVC: UIViewController {
  
  @IBOutlet weak var segmentLocationTracker: UISegmentedControl!
  @IBOutlet weak var userTopEntry: UITextField!
  @IBOutlet weak var userBottomEntry: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Swipe gesture to dismiss forecast preferences
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
  
  //TODO: Hide user input when segment location is on "Cuurent Location"
  @IBAction func locationTracker(_ sender: UISegmentedControl) {
    if segmentLocationTracker.isEnabledForSegment(at: 0) {
      userTopEntry.isHidden = true
    }
    else {
      userTopEntry.isHidden = false
    }
  }
  
  @IBAction func saveChanges(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dismissModal(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}


// MARK: dismiss keyboard
extension ForecastPreferencesVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userTopEntry.resignFirstResponder()
    userBottomEntry.resignFirstResponder()
  }
}

// MARK: - Method to dismiss view by swiping down
extension ForecastPreferencesVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
}
