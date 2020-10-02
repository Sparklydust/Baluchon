//
//  TranslatorVC.swift
//  Baluchon
//
//  Created by Roland Lariotte on 28/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ChangeLanguageDelegate: AnyObject {
  func userSetLanguages(top: LanguageTuple, bottom: LanguageTuple)
}

class TranslatorPreferencesVC: UIViewController {

  let defaults = UserDefaults.standard
  static let topLanPickerKey = "topTranslatorPicker"
  static let bottomLanPickerKey = "bottomTranslatorPicker"
  static let topLanCodeKey = "topTranslatorCode"
  static let bottomLanCodeKey = "bottomTranslatorCode"
  static let topLanguageKey = "topLanguage"
  static let bottomLanguageKey = "bottomLanguage"
  static let topLanImageKey = "topTranslatorImage"
  static let bottomLanImageKey = "bottomTranslatorImage"

  @IBOutlet weak var topLanguageLabel: UILabel!
  @IBOutlet weak var topLanguagePicker: UIPickerView!
  @IBOutlet weak var bottomLanguageLabel: UILabel!
  @IBOutlet weak var bottomLanguagePicker: UIPickerView!

  weak var delegate: ChangeLanguageDelegate?

  var topPickerOptions = [
    (code: String, language: String, flag: UIImage, country: String)]()
  var bottomPickerOptions = [
    (code: String, language: String, flag: UIImage, country: String)]()

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
    defaults.set(topUserIndex,
                 forKey: TranslatorPreferencesVC.topLanPickerKey)
    defaults.set(bottomUserIndex,
                 forKey: TranslatorPreferencesVC.bottomLanPickerKey)
    defaults.set(userLanguagesChoice.top.code,
                 forKey: TranslatorPreferencesVC.topLanCodeKey)
    defaults.set(userLanguagesChoice.Bottom.code,
                 forKey: TranslatorPreferencesVC.bottomLanCodeKey)
    defaults.set(userLanguagesChoice.top.language,
                 forKey: TranslatorPreferencesVC.topLanguageKey)
    defaults.set(userLanguagesChoice.Bottom.language,
                 forKey: TranslatorPreferencesVC.bottomLanguageKey)
    defaults.set(userLanguagesChoice.top.country,
                 forKey: TranslatorPreferencesVC.topLanImageKey)
    defaults.set(userLanguagesChoice.Bottom.country,
                 forKey: TranslatorPreferencesVC.bottomLanImageKey)
  }

  //MARK: - Cancel and Save Changes actions
  @IBAction func saveChanges(_ sender: Any) {
    createTopAndBottomLanguage()
    delegate?.userSetLanguages(
      top: userLanguagesChoice.top, bottom: userLanguagesChoice.Bottom)
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

  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    if (pickerView.tag == 1) {
      return topPickerOptions.count
    }
    else {
      return bottomPickerOptions.count
    }
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                  forComponent component: Int) -> String? {
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
    let swipeToCancel = UISwipeGestureRecognizer(
      target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
}

//MARK: - Set pickerViews to user selections
extension TranslatorPreferencesVC {
  func setPickerViewToUserSelection() {
    topLanguagePicker.selectRow(defaults.integer(
      forKey: TranslatorPreferencesVC.topLanPickerKey),
                                inComponent: 0, animated: true)
    bottomLanguagePicker.selectRow(defaults.integer(
      forKey: TranslatorPreferencesVC.bottomLanPickerKey),
                                   inComponent: 0, animated: true)
  }
}
