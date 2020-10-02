//
//  ExchangePreferencesVC.swift
//  Baluchon
//
//  Created by Roland Lariotte on 28/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ChangeCurrencyDelegate: AnyObject {
  func userSetCurrency(top: CurrencyTuple, bottom: CurrencyTuple)
}

class ExchangePreferencesVC: UIViewController {

  let defaults = UserDefaults.standard
  static let topExPickerKey = "topExchangePicker"
  static let bottomExPickerKey = "bottomExchangePicker"
  static let topExSignKey = "topExchangeSign"
  static let bottomExSignKey = "bottomExchangeSign"
  static let topExSymbolKey = "topExchangeSymbol"
  static let bottomExSymbolKey = "bottomExchangeSymbol"
  static let topExImageKey = "topExchangeImage"
  static let bottomExImageKey = "bottomExchangeImage"

  @IBOutlet weak var topCurrencyLabel: UILabel!
  @IBOutlet weak var topCurrencyPicker: UIPickerView!
  @IBOutlet weak var bottomCurrencyLabel: UILabel!
  @IBOutlet weak var bottomCurrencyPicker: UIPickerView!

  weak var delegate: ChangeCurrencyDelegate?

  var topPickerOptions = [
    (symbol: String, name: String, sign: String, flag: UIImage, country: String)]()
  var bottomPickerOptions = [
    (symbol: String, name: String, sign: String, flag: UIImage, country: String)]()

  var userCurrencyChoice: Currencies!
  var money = CurrencyISOCode()

  override func viewDidLoad() {
    super.viewDidLoad()
    swapDownToCancelView()

    // Setting up pickerView delegate
    self.topCurrencyPicker.delegate = self
    self.bottomCurrencyPicker.delegate = self
    self.topCurrencyPicker.dataSource = self
    self.bottomCurrencyPicker.dataSource = self
    topPickerOptions = money.currencyISOCode
    bottomPickerOptions = money.currencyISOCode

    // Retrieve user pickerViews last position
    setPickerViewToUserSelection()
  }

  // User top and bottom pickerView choices
  func createTopAndBottomCurrency() {
    let topUserIndex = topCurrencyPicker.selectedRow(inComponent: 0)
    let bottomUserIndex = bottomCurrencyPicker.selectedRow(inComponent: 0)
    let topUserChoice = money.currencyISOCode[topUserIndex]
    let bottomUserChoice = money.currencyISOCode[bottomUserIndex]
    userCurrencyChoice = Currencies(top: topUserChoice, bottom: bottomUserChoice)

    // Save user pickerViews Choice
    defaults.set(topUserIndex,
                 forKey: ExchangePreferencesVC.topExPickerKey)
    defaults.set(bottomUserIndex,
                 forKey: ExchangePreferencesVC.bottomExPickerKey)
    defaults.set(userCurrencyChoice.top.sign,
                 forKey: ExchangePreferencesVC.topExSignKey)
    defaults.set(userCurrencyChoice.bottom.sign,
                 forKey: ExchangePreferencesVC.bottomExSignKey)
    defaults.set(userCurrencyChoice.top.symbol,
                 forKey: ExchangePreferencesVC.topExSymbolKey)
    defaults.set(userCurrencyChoice.bottom.symbol,
                 forKey: ExchangePreferencesVC.bottomExSymbolKey)
    defaults.set(userCurrencyChoice.top.country,
                 forKey: ExchangePreferencesVC.topExImageKey)
    defaults.set(userCurrencyChoice.bottom.country,
                 forKey: ExchangePreferencesVC.bottomExImageKey)
  }

  //MARK: - Cancel and Save Changes actions
  @IBAction func saveChanges(_ sender: Any) {
    createTopAndBottomCurrency()
    delegate?.userSetCurrency(
      top: userCurrencyChoice.top, bottom: userCurrencyChoice.bottom)
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func dismissModal(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK: - Showing off top and bottom picker view options
extension ExchangePreferencesVC: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    if (pickerView.tag == 1) {
      return topPickerOptions.count
    }
    else {
      return bottomPickerOptions.count
    }
  }

  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int, forComponent component: Int) -> String? {
    if (pickerView.tag == 1) {
      return topPickerOptions[row].name + "  " + topPickerOptions[row].sign
    }
    else {
      return bottomPickerOptions[row].name + "  " + bottomPickerOptions[row].sign
    }
  }
}

//MARK: - Method to dismiss view by swiping down
extension ExchangePreferencesVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
}

//MARK: - Swipe Down to cancel view
extension ExchangePreferencesVC {
  func swapDownToCancelView() {
    let swipeToCancel = UISwipeGestureRecognizer(
      target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
}

//MARK: - Set pickerViews to user selections
extension ExchangePreferencesVC {
  func setPickerViewToUserSelection() {
    topCurrencyPicker.selectRow(defaults.integer(
      forKey: ExchangePreferencesVC.topExPickerKey),
                                inComponent: 0, animated: true)
    bottomCurrencyPicker.selectRow(defaults.integer(
      forKey: ExchangePreferencesVC.bottomExPickerKey),
                                   inComponent: 0, animated: true)
  }
}
