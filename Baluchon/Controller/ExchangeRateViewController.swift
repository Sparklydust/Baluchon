//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Roland Lariotte on 25/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
  
  @IBOutlet weak var topFlag: UIButton!
  @IBOutlet weak var userEntry: UITextField!
  @IBOutlet weak var bottomFlag: UIButton!
  @IBOutlet weak var exchangeResponse: UITextField!
  @IBOutlet weak var topStackView: UIStackView!
  @IBOutlet weak var bottomStackView: UIStackView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = true
    
    // Swipe gesture to move between tab Bar
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    leftSwipe.direction = .left
    self.view.addGestureRecognizer(leftSwipe)
  }
  
  // Swap the currency between each other
  @IBAction func swapCurrency(_ sender: UIButton) {
  }
  
  // To get currency convertion after user entry amount
  @IBAction func getCurrencyConvertion(_ sender: UIButton) {
    
  }
  
  
}

//MARK: - Method to swipe between TabBar
extension ExchangeRateViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .left {
      self.tabBarController!.selectedIndex += 1
      userEntry.resignFirstResponder()
    }
  }
}

// MARK: - Perform Segue to currency preferences
extension ExchangeRateViewController {
  @IBAction func changeBottomCurrency(_ sender: UIButton) {
    performSegue(withIdentifier: "goToPreferences", sender: self)
  }
  
  @IBAction func changeTopCurrency(_ sender: UIButton) {
    performSegue(withIdentifier: "goToPreferences", sender: self)
  }
}

// MARK: - dismiss keyboard
extension ExchangeRateViewController {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userEntry.resignFirstResponder()
  }
}
