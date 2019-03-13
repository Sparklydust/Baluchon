//
//  Currency.swift
//  Baluchon
//
//  Created by Roland Lariotte on 01/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import UIKit

typealias CurrencyTuple = (symbol: String, name: String, sign: String, flag: UIImage)

struct Currencies {
  var top: CurrencyTuple
  var bottom: CurrencyTuple
}

// Structures that get the result after the API call
struct ConversionResult {
  var exchangeRate: Double
  let exchangeResult: Double
}

struct ExchangeRoot: Decodable {
  let info: Info
  let result: Double
}

struct Info: Decodable {
  let rate: Double
}

//TODO: Reverse Arabic language to avoid bug on the exchange rate user output
let currencyISOCode: [CurrencyTuple] = [
  ("EUR", "Euro", "€", #imageLiteral(resourceName: "european-union")),
  ("USD", "United States Dollars", "$", #imageLiteral(resourceName: "united-states-of-america")),
  ("GBP", "British Pound Sterling", "£", #imageLiteral(resourceName: "united-kingdom")),
  ("AED", "United Arab Emirates Dirham", "د.إ", #imageLiteral(resourceName: "united-arab-emirates")), // Arabic letters
  ("AFN", "Afghan Afghani", "Af", #imageLiteral(resourceName: "afghanistan")),
  ("ALL", "Albanian Lek", "L", #imageLiteral(resourceName: "albania")),
  ("AMD", "Armenian Dram", "Դ", #imageLiteral(resourceName: "armenia")),
  ("ANG", "Netherlands Antillean Guilder", "ƒ", #imageLiteral(resourceName: "curacao")),
  ("AOA", "Angolan Kwanza", "Kz", #imageLiteral(resourceName: "angola")),
  ("ARS", "Argentine Peso", "$", #imageLiteral(resourceName: "argentina")),
  ("AUD", "Australian Dollar", "$", #imageLiteral(resourceName: "australia")),
  ("AWG", "Aruban Florin", "ƒ", #imageLiteral(resourceName: "aruba")),
  ("AZN", "Azerbaijani Manat", "ман", #imageLiteral(resourceName: "azerbaijan")),
  ("BAM", "Bosnia-Herzegovina Convertible Mark", "КМ", #imageLiteral(resourceName: "bosnia-and-herzegovina")),
  ("BBD", "Barbadian Dollar", "$", #imageLiteral(resourceName: "barbados")),
  ("BDT", "Bangladeshi Taka", "৳", #imageLiteral(resourceName: "bangladesh")),
  ("BGN", "Bulgarian Lev", "лв", #imageLiteral(resourceName: "bulgaria")),
  ("BHD", "Bahraini Dinar", "ب.د", #imageLiteral(resourceName: "bahrain")), // Arabic letters
  ("BIF", "Burundian Franc", "₣", #imageLiteral(resourceName: "burundi")),
  ("BMD", "Bermudan Dollar", "$", #imageLiteral(resourceName: "bermuda")),
  ("BND", "Brunei Dollar", "$", #imageLiteral(resourceName: "brunei")),
  ("BOB", "Bolivian Boliviano", "Bs.", #imageLiteral(resourceName: "bolivia")),
  ("BRL", "Brazilian Real", "R$", #imageLiteral(resourceName: "brazil")),
  ("BSD", "Bahamian Dollar", "$", #imageLiteral(resourceName: "bahamas")),
  ("BTC", "Bitcoin", "₿", #imageLiteral(resourceName: "bitcoin")),
  ("BTN", "Bhutanese Ngultrum", "", #imageLiteral(resourceName: "bhutan")),
  ("BWP", "Botswanan Pula", "P", #imageLiteral(resourceName: "botswana")),
  ("BYR", "Belarusian Ruble", "Br", #imageLiteral(resourceName: "belarus")),
  ("BZD", "Belize Dollar", "$", #imageLiteral(resourceName: "belize")),
  ("CAD", "Canadian Dollar", "$", #imageLiteral(resourceName: "canada")),
  ("CDF", "Congolese Franc", "₣", #imageLiteral(resourceName: "republic-of-the-congo")),
  ("CHF", "Swiss Franc", "₣", #imageLiteral(resourceName: "switzerland")),
  ("CLF", "Chilean Unit of Account (UF)", "$", #imageLiteral(resourceName: "chile")),
  ("CLP", "Chilean Peso", "$", #imageLiteral(resourceName: "chile")),
  ("CNY", "Chinese Yuan", "¥", #imageLiteral(resourceName: "china")),
  ("COP", "Colombian Peso", "$", #imageLiteral(resourceName: "colombia")),
  ("CRC", "Costa Rican Colón", "₡", #imageLiteral(resourceName: "costa-rica")),
  ("CUC", "Cuban Convertible Peso", "$", #imageLiteral(resourceName: "cuba")),
  ("CUP", "Cuban Peso", "$", #imageLiteral(resourceName: "cuba")),
  ("CVE", "Cape Verdean Escudo", "$", #imageLiteral(resourceName: "cape-verde")),
  ("CZK", "Czech Republic Koruna", "Kč", #imageLiteral(resourceName: "czech-republic")),
  ("DJF", "Djiboutian Franc", "₣", #imageLiteral(resourceName: "djibouti")),
]
