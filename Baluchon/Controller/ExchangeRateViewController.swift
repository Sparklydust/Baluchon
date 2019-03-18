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
  @IBOutlet weak var topSign: UILabel!
  @IBOutlet weak var swapButton: UIButton!
  @IBOutlet weak var bottomFlag: UIButton!
  @IBOutlet weak var exchangeResponse: UITextField!
  @IBOutlet weak var bottomSign: UILabel!
  @IBOutlet weak var convertButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var rateLabel: UILabel!

  var params = [String: String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupParamsAtLaunch()
    swapBetweenTabBars()
    userEntry.delegate = self
  }

  // TODO: - Flags and data get back to their origin place when asking for new conversion after a switch action was made.
  // TODO: - Save user settings on this VC

  // Swap the currency section between each other
  @IBAction func swapCurrency(_ sender: UIButton) {
    clearTextViews()
    APIsRuler.shared.swapElements(&userEntry.text, &exchangeResponse.text)
    APIsRuler.shared.swapElements(&topSign.text, &bottomSign.text)
    if let topFlagImageView = topFlag.imageView, let bottomFlagImageView = bottomFlag.imageView {
      APIsRuler.shared.swapElements(&topFlagImageView.image, &bottomFlagImageView.image)
    }
  }
}

//MARK: - Method to limit the number of decimal points
extension ExchangeRateViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "," {
      if textField.text!.contains(",") {
        return false
      }
    }
    return true
  }
}

//MARK: - Delegate of the ChangeCurrency protocol that brings user preferences
extension ExchangeRateViewController: ChangeCurrencyDelegate {
  func userSetCurrency(top: CurrencyTuple, bottom: CurrencyTuple) {
    self.topFlag.setImage(top.flag, for: .normal)
    self.topSign.text = top.sign
    self.bottomFlag.setImage(bottom.flag, for: .normal)
    self.bottomSign.text = bottom.sign
    clearTextViews()

    params = ["from": top.symbol, "to": bottom.symbol]
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPreferences" {
      let destinationVC = segue.destination as! ExchangePreferencesVC
      destinationVC.delegate = self
    }
  }
}

//MARK: - Updating VC or showing off alert when data comes back or not
extension ExchangeRateViewController {
  // User asks for the conversion of his input
  @IBAction func convertCurrencies(_ sender: UIButton) {
    triggerActivityIndicator(true)
    // Networking with only dot number
    let dotOnly = userEntry.text?.replacingOccurrences(of: ",", with: ".")
    APIsRuler.shared.getExchangeRate(from: params["from"]!, to: params["to"]!, amount: dotOnly!) {
      (success, conversionResult) in
      self.triggerActivityIndicator(false)
      if success, let conversionResult = conversionResult {
        self.userEntry.becomeFirstResponder()
        self.updateUserView(rate: conversionResult, result: conversionResult)
      }
      else {
        self.presentAlert()
      }
    }
  }

  func updateUserView(rate: ConversionResult, result: ConversionResult) {
    rateLabel.text = "1 \(self.topSign.text!)  =  \(rate.exchangeRate) \(self.bottomSign.text!)"
    exchangeResponse.text = "\(result.exchangeResult)"
  }

  func presentAlert() {
    let alertVC = UIAlertController(title: "Error", message: "Sorry, there was an error loading data", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }

  // Disable buttons and show Activity Indicator if true
  func triggerActivityIndicator(_ action: Bool) {
    convertButton.isHidden = action
    activityIndicator.isHidden = !action
    swapButton.isEnabled = !action
    userEntry.isEnabled = !action
    topFlag.isEnabled = !action
    bottomFlag.isEnabled = !action
  }

  func clearTextViews() {
    userEntry.text! = ""
    exchangeResponse.text! = ""
  }
}

//MARK: - Methods to swipe between TabBars
extension ExchangeRateViewController {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .left {
      self.tabBarController!.selectedIndex += 1
      userEntry.resignFirstResponder()
    }
  }

  func swapBetweenTabBars() {
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    leftSwipe.direction = .left
    self.view.addGestureRecognizer(leftSwipe)
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

//MARK: - Dismiss keyboard
extension ExchangeRateViewController {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    userEntry.resignFirstResponder()
  }
}

//MARK: - Parameters at first app launch
extension ExchangeRateViewController {
  func setupParamsAtLaunch() {
    triggerActivityIndicator(false)
    params = ["from": "EUR", "to": "USD"]
    topSign.text! = "€"
    bottomSign.text! = "$"
  }
}
