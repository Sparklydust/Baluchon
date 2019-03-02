//
//  ExchangePreferencesVC.swift
//  Baluchon
//
//  Created by Roland Lariotte on 28/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ExchangePreferencesVC: UIViewController {
  
  @IBOutlet weak var topCurrencyLabel: UILabel!
  @IBOutlet weak var topCurrencyPicker: UIPickerView!
  @IBOutlet weak var bottomCurrencyLabel: UILabel!
  @IBOutlet weak var bottomCurrencyPicker: UIPickerView!
  
  var topPickerOptions = [String]()
  var bottomPickerOptions = [String]()
  
  // TODO: - Create a struct Currencies
//  var userCurrenciesChoice = Currencies()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.topCurrencyPicker.delegate = self
    self.bottomCurrencyPicker.delegate = self
    self.topCurrencyPicker.dataSource = self
    self.bottomCurrencyPicker.dataSource = self
    topPickerOptions = ["Euro - €", "Dollars - $"]
    bottomPickerOptions = ["Euro - €", "Dollars - $"]
    
    // Swipe gesture to dismiss currency preferences
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
  
  //TODO: Set up pickerViews output
  // User top and bottom pickerView choices
//  func createTopAndBottomCurrency() {
//    let topUserIndex = topCurrencyPicker.selectedRow(inComponent: 0)
//    let bottomUserIndex = bottomCurrencyPicker.selectedRow(inComponent: 0)
//    let topUserInput = currencyISOCode[topUserIndex]
//    let bottomUserInput = currencyISOCode[bottomUserIndex]
//    userCurrenciesChoice = Currencies(topChoice: topUserInput, BottomChoice: bottomUserInput)
//  }
  
  // MARK: - Cancel and Save Changes actions
  @IBAction func saveChanges(_ sender: Any) {
    //createTopAndBottomCurrency()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dismissModal(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Showing off top and bottom picker view options
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
      return topPickerOptions[row]
    }
    else {
      return bottomPickerOptions[row]
    }
  }
}

// MARK: - Method to dismiss view by swiping down
extension ExchangePreferencesVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
}
