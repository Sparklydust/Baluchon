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
