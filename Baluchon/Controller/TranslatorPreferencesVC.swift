//
//  TranslatorVC.swift
//  Baluchon
//
//  Created by Roland Lariotte on 28/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ChangeLanguageDelegate {
  func userSetLanguages(top: LanguageTuple, bottom: LanguageTuple)
}

class TranslatorPreferencesVC: UIViewController {
  
  let defaults = UserDefaults.standard
  let topKey = "topTranslatorPicker"
  let bottomKey = "bottomTranslatorPicker"
  
  @IBOutlet weak var topLanguageLabel: UILabel!
  @IBOutlet weak var topLanguagePicker: UIPickerView!
  @IBOutlet weak var bottomLanguageLabel: UILabel!
  @IBOutlet weak var bottomLanguagePicker: UIPickerView!
  
  var delegate: ChangeLanguageDelegate?
  
  var topPickerOptions = [(code: String, language: String, flag: UIImage)]()
  var bottomPickerOptions = [(code: String, language: String, flag: UIImage)]()
  
  var userLanguagesChoice: Languages!
  var language = WorldLanguages()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    swapDownToCancelView()
    
    // Setting up pickerView delegate
    self.topLanguagePicker.delegate = self
    self.bottomLanguagePicker.delegate = self
    self.topLanguagePicker.dataSource = self
    self.bottomLanguagePicker.dataSource = self
    topPickerOptions = language.worldLanguages
    bottomPickerOptions = language.worldLanguages
    
    // Retrieve user pickerViews last position
    setPickerViewToUserSelection()
  }
  
  // User top and bottom pickerView choices
  func createTopAndBottomLanguage() {
    let topUserIndex = topLanguagePicker.selectedRow(inComponent: 0)
    let bottomUserIndex = bottomLanguagePicker.selectedRow(inComponent: 0)
    let topUserChoice = language.worldLanguages[topUserIndex]
    let bottomUserChoice = language.worldLanguages[bottomUserIndex]
    userLanguagesChoice = Languages(top: topUserChoice, Bottom: bottomUserChoice)
    
    // Save user pickerViews Choice
    defaults.set(topUserIndex, forKey: topKey)
    defaults.set(bottomUserIndex, forKey: bottomKey)
  }

  //MARK: - Cancel and Save Changes actions
  @IBAction func saveChanges(_ sender: Any) {
    createTopAndBottomLanguage()
    delegate?.userSetLanguages(top: userLanguagesChoice.top, bottom: userLanguagesChoice.Bottom)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dismissModal(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK: - Showing off top and bottom picker view options
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
      return topPickerOptions[row].language
    }
    else {
      return bottomPickerOptions[row].language
    }
  }
}

//MARK: - Method to dismiss view by swiping down
extension TranslatorPreferencesVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
}

//MARK: - Swipe Down to cancel view
extension TranslatorPreferencesVC {
  func swapDownToCancelView() {
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
}

//MARK: - Set pickerViews to user selections
extension TranslatorPreferencesVC {
  func setPickerViewToUserSelection() {
    topLanguagePicker.selectRow(defaults.integer(forKey: topKey), inComponent: 0, animated: true)
    bottomLanguagePicker.selectRow(defaults.integer(forKey: bottomKey), inComponent: 0, animated: true)
  }
}
