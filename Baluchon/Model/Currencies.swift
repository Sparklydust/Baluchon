//
//  Currency.swift
//  Baluchon
//
//  Created by Roland Lariotte on 01/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import UIKit

typealias CurrencyTuple = (name: String, symbol: String, flag: UIImage )

struct Currencies {
  var top: CurrencyTuple
  var bottom: CurrencyTuple
}

let currencyISOCode: [CurrencyTuple] = [
  ("Euro", "€", #imageLiteral(resourceName: "european-union")),
  ("Dollars", "$", #imageLiteral(resourceName: "united-states-of-america")),
  ("Pound Sterling", "£", #imageLiteral(resourceName: "united-kingdom"))
]
