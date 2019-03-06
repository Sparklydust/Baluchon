//
//  ExchangePreferencesVC.swift
//  Baluchon
//
//  Created by Roland Lariotte on 28/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ChangeCurrencyDelegate {
  func userSetCurrency(top: CurrencyTuple, bottom: CurrencyTuple)
}

class ExchangePreferencesVC: UIViewController {
  
  @IBOutlet weak var topCurrencyLabel: UILabel!
  @IBOutlet weak var topCurrencyPicker: UIPickerView!
  @IBOutlet weak var bottomCurrencyLabel: UILabel!
  @IBOutlet weak var bottomCurrencyPicker: UIPickerView!
  
  var delegate: ChangeCurrencyDelegate?
  
  var topPickerOptions = [(name: String, symbol: String, flag: UIImage)]()
  var bottomPickerOptions = [(name: String, symbol: String, flag: UIImage)]()
  
  var userCurrencyChoice: Currencies!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.topCurrencyPicker.delegate = self
    self.bottomCurrencyPicker.delegate = self
    self.topCurrencyPicker.dataSource = self
    self.bottomCurrencyPicker.dataSource = self
    topPickerOptions = currencyISOCode
    bottomPickerOptions = currencyISOCode
    
    // Swipe gesture to dismiss currency preferences
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
  
   // User top and bottom pickerView choices
  func createTopAndBottomCurrency() {
    let topUserIndex = topCurrencyPicker.selectedRow(inComponent: 0)
    let bottomUserIndex = bottomCurrencyPicker.selectedRow(inComponent: 0)
    let topUserChoice = currencyISOCode[topUserIndex]
    let bottomUserChoice = currencyISOCode[bottomUserIndex]
    userCurrencyChoice = Currencies(top: topUserChoice, bottom: bottomUserChoice)
  }
  
  //MARK: - Cancel and Save Changes actions
  @IBAction func saveChanges(_ sender: Any) {
    createTopAndBottomCurrency()
    delegate?.userSetCurrency(top: userCurrencyChoice.top, bottom: userCurrencyChoice.bottom)
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
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if (pickerView.tag == 1) {
      return topPickerOptions.count
    }
    else {
      return bottomPickerOptions.count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if (pickerView.tag == 1) {
      return topPickerOptions[row].name + "  " + topPickerOptions[row].symbol
    }
    else {
      return bottomPickerOptions[row].name + "  " + bottomPickerOptions[row].symbol
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
