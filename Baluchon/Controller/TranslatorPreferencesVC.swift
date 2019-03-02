//
//  TranslatorVC.swift
//  Baluchon
//
//  Created by Roland Lariotte on 28/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class TranslatorPreferencesVC: UIViewController {
  
  @IBOutlet weak var topLanguageLabel: UILabel!
  @IBOutlet weak var topLanguagePicker: UIPickerView!
  @IBOutlet weak var bottomLanguageLabel: UILabel!
  @IBOutlet weak var bottomLanguagePicker: UIPickerView!
  
  var topPickerOptions = [String]()
  var bottomPickerOptions = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.topLanguagePicker.delegate = self
    self.bottomLanguagePicker.delegate = self
    self.topLanguagePicker.dataSource = self
    self.bottomLanguagePicker.dataSource = self
    topPickerOptions = ["worldLanguages", "Language1", "Language2"]
    bottomPickerOptions = ["Anglais", "Français"]
    
    // Swipe gesture to dismiss translator preferences
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
  
  // TODO: Set up pickerViews output
  // User top and bottom pickerView choices
//  func createTopAndBottomLanguage() {
//    let topUserIndex = topLanguagePicker.selectedRow(inComponent: 0)
//    let bottomUserIndex = bottomLanguagePicker.selectedRow(inComponent: 0)
//  }

  // MARK: - Cancel and Save Changes actions
  @IBAction func saveChanges(_ sender: Any) {
    //createTopAndBottomLanguage()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dismissModal(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Showing off top and bottom picker view options
extension TranslatorPreferencesVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
extension TranslatorPreferencesVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
}
