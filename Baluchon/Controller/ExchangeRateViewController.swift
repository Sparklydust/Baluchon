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
  @IBOutlet weak var topSymbol: UILabel!
  @IBOutlet weak var bottomFlag: UIButton!
  @IBOutlet weak var exchangeResponse: UITextField!
  @IBOutlet weak var bottomSymbol: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var apisRuler = APIsRuler()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = true
    
    // Swipe gesture to move between tab Bar
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    leftSwipe.direction = .left
    self.view.addGestureRecognizer(leftSwipe)
  }
  
  //TODO: Swap flag
  // Swap the currency section between each other
  @IBAction func swapCurrency(_ sender: UIButton) {
    apisRuler.swapElements(&userEntry.text, &exchangeResponse.text)
    apisRuler.swapElements(&topSymbol.text, &bottomSymbol.text)
  }
  
  // To get currency convertion after user entry amount
  @IBAction func getCurrencyConvertion(_ sender: UIButton) {
  }
}

//MARK: - Method to swipe between TabBars
extension ExchangeRateViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .left {
      self.tabBarController!.selectedIndex += 1
      userEntry.resignFirstResponder()
    }
  }
}

//MARK: - Perform Segue to currency preferences
extension ExchangeRateViewController {
  @IBAction func changeBottomCurrency(_ sender: UIButton) {
    performSegue(withIdentifier: "goToPreferences", sender: self)
  }
  
  @IBAction func changeTopCurrency(_ sender: UIButton) {
    performSegue(withIdentifier: "goToPreferences", sender: self)
  }
}

//MARK: - dismiss keyboard
extension ExchangeRateViewController {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userEntry.resignFirstResponder()
  }
}

//MARK: - Delegate of the ChangeCurrency protocol
extension ExchangeRateViewController: ChangeCurrencyDelegate {
  func userSetCurrency(top: CurrencyTuple, bottom: CurrencyTuple) {
    self.topFlag.setImage(top.flag, for: .normal)
    self.topSymbol.text = top.symbol
    self.bottomFlag.setImage(bottom.flag, for: .normal)
    self.bottomSymbol.text = bottom.symbol
    
    // TODO: Call the api with a function here to get the Exchange Rate
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPreferences" {
      let destinationVC = segue.destination as! ExchangePreferencesVC
      destinationVC.delegate = self
    }
  }
}
