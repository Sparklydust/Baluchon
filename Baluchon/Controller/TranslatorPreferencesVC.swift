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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func saveChanges(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func dismissModal(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
