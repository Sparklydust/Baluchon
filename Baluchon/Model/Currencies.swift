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
// Structure to manage the currencyISOCode in picker Views
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

// World Currencies
class CurrencyISOCode {
  let currencyISOCode: [CurrencyTuple] = [
    ("AED", "United Arab Emirates Dirham", "د.إ", #imageLiteral(resourceName: "united-arab-emirates")),
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
    ("BHD", "Bahraini Dinar", "ب.د", #imageLiteral(resourceName: "bahrain")),
    ("BIF", "Burundian Franc", "₣", #imageLiteral(resourceName: "burundi")),
    ("BMD", "Bermudan Dollar", "$", #imageLiteral(resourceName: "bermuda")),
    ("BND", "Brunei Dollar", "$", #imageLiteral(resourceName: "brunei")),
    ("BOB", "Bolivian Boliviano", "Bs.", #imageLiteral(resourceName: "bolivia")),
    ("BRL", "Brazilian Real", "R$", #imageLiteral(resourceName: "brazil")),
    ("BSD", "Bahamian Dollar", "$", #imageLiteral(resourceName: "bahamas")),
    ("BTC", "Bitcoin", "₿", #imageLiteral(resourceName: "bitcoin")),
    ("BTN", "Bhutanese Ngultrum", "Nu.", #imageLiteral(resourceName: "bhutan")),
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
    ("DKK", "Danish Krone", "kr", #imageLiteral(resourceName: "denmark")),
    ("DOP", "Dominican Peso", "$", #imageLiteral(resourceName: "dominican-republic")),
    ("DZD", "Algerian Dinar", "د.ج", #imageLiteral(resourceName: "algeria")),
    ("EGP", "Egyptian Pound", "£", #imageLiteral(resourceName: "egypt")),
    ("ERN", "Eritrean Nakfa", "Nfk", #imageLiteral(resourceName: "eritrea")),
    ("ETB", "Ethiopian Birr", "ብር", #imageLiteral(resourceName: "ethiopia")),
    ("EUR", "Euro", "€", #imageLiteral(resourceName: "european-union")),
    ("FJD", "Fijian Dollar", "$", #imageLiteral(resourceName: "fiji")),
    ("FKP", "Falkland Islands Pound", "£", #imageLiteral(resourceName: "falkland-islands")),
    ("GBP", "British Pound Sterling", "£", #imageLiteral(resourceName: "united-kingdom")),
    ("GEL", "Georgian Lari", "ლ", #imageLiteral(resourceName: "georgia")),
    ("GGP", "Guernsey Pound", "£", #imageLiteral(resourceName: "guernsey")),
    ("GHS", "Ghanaian Cedi", "₵", #imageLiteral(resourceName: "ghana")),
    ("GIP", "Gibraltar Pound", "£", #imageLiteral(resourceName: "gibraltar")),
    ("GMD", "Gambian Dalasi", "D", #imageLiteral(resourceName: "gambia")),
    ("GNF", "Guinean Franc", "₣", #imageLiteral(resourceName: "guinea")),
    ("GTQ", "Guatemalan Quetzal", "Q", #imageLiteral(resourceName: "guatemala")),
    ("GYD", "Guyanaese Dollar", "$", #imageLiteral(resourceName: "guyana")),
    ("HKD", "Hong Kong Dollar", "$", #imageLiteral(resourceName: "hong-kong")),
    ("HNL", "Honduran Lempira", "L", #imageLiteral(resourceName: "honduras")),
    ("HRK", "Croatian Kuna", "Kn", #imageLiteral(resourceName: "croatia")),
    ("HTG", "Haitian Gourde", "G", #imageLiteral(resourceName: "haiti")),
    ("HUF", "Hungarian Forint", "Ft", #imageLiteral(resourceName: "hungary")),
    ("IDR", "Indonesian Rupiah", "Rp", #imageLiteral(resourceName: "indonesia")),
    ("ILS", "Israeli New Sheqel", "₪", #imageLiteral(resourceName: "israel")),
    ("IMP", "Manx pound", "£", #imageLiteral(resourceName: "isle-of-man")),
    ("INR", "Indian Rupee", "₹", #imageLiteral(resourceName: "india")),
    ("IQD", "Iraqi Dinar", "ع.د", #imageLiteral(resourceName: "iraq")),
    ("IRR", "Iranian Rial", "﷼", #imageLiteral(resourceName: "iran")),
    ("ISK", "Icelandic Króna", "Kr", #imageLiteral(resourceName: "iceland")),
    ("JEP", "Jersey Pound", "£", #imageLiteral(resourceName: "jersey")),
    ("JMD", "Jamaican Dollar", "$", #imageLiteral(resourceName: "jamaica")),
    ("JOD", "Jordanian Dinar", "د.ا", #imageLiteral(resourceName: "jordan")),
    ("JPY", "Japanese Yen", "¥", #imageLiteral(resourceName: "japan")),
    ("KES", "Kenyan Shilling", "Sh", #imageLiteral(resourceName: "kenya")),
    ("KGS", "Kyrgystani Som", "Лв", #imageLiteral(resourceName: "kyrgyzstan")),
    ("KHR", "Cambodian Riel", "៛", #imageLiteral(resourceName: "cambodia")),
    ("KMF", "Comorian Franc", "CF", #imageLiteral(resourceName: "comoros")),
    ("KPW", "North Korean Won", "₩", #imageLiteral(resourceName: "north-korea")),
    ("KRW", "South Korean Won", "₩", #imageLiteral(resourceName: "south-korea")),
    ("KWD", "Kuwaiti Dinar", "د.ك", #imageLiteral(resourceName: "kuwait")),
    ("KYD", "Cayman Islands Dollar", "$", #imageLiteral(resourceName: "cayman-islands")),
    ("KZT", "Kazakhstani Tenge", "〒", #imageLiteral(resourceName: "kazakhstan")),
    ("LAK", "Laotian Kip", "₭", #imageLiteral(resourceName: "laos")),
    ("LBP", "Lebanese Pound", "ل.ل", #imageLiteral(resourceName: "lebanon")),
    ("LKR", "Sri Lankan Rupee", "Rs", #imageLiteral(resourceName: "sri-lanka")),
    ("LRD", "Liberian Dollar", "$", #imageLiteral(resourceName: "liberia")),
    ("LSL", "Lesotho Loti", "L", #imageLiteral(resourceName: "lesotho")),
    ("LYD", "Libyan Dinar", "ل.د", #imageLiteral(resourceName: "libya")),
    ("MAD", "Moroccan Dirham", "د.م.", #imageLiteral(resourceName: "morocco")),
    ("MDL", "Moldovan Leu", "L", #imageLiteral(resourceName: "moldova")),
    ("MGA", "Malagasy Ariary", "Ar", #imageLiteral(resourceName: "madagascar")),
    ("MKD", "Macedonian Denar", "ден", #imageLiteral(resourceName: "republic-of-macedonia")),
    ("MMK", "Myanma Kyat", "K", #imageLiteral(resourceName: "myanmar")),
    ("MNT", "Mongolian Tugrik", "₮", #imageLiteral(resourceName: "mongolia")),
    ("MOP", "Macanese Pataca", "P", #imageLiteral(resourceName: "macao")),
    ("MRO", "Mauritanian Ouguiya", "UM", #imageLiteral(resourceName: "mauritania")),
    ("MUR", "Mauritian Rupee", "₨", #imageLiteral(resourceName: "mauritius")),
    ("MVR", "Maldivian Rufiyaa", "ރ.", #imageLiteral(resourceName: "maldives")),
    ("MWK", "Malawian Kwacha", "MK", #imageLiteral(resourceName: "malawi")),
    ("MXN", "Mexican Peso", "$", #imageLiteral(resourceName: "mexico")),
    ("MYR", "Malaysian Ringgit", "RM", #imageLiteral(resourceName: "malaysia")),
    ("MZN", "Mozambican Metical", "MTn", #imageLiteral(resourceName: "mozambique")),
    ("NAD", "Namibian Dollar", "$", #imageLiteral(resourceName: "namibia")),
    ("NGN", "Nigerian Naira", "₦", #imageLiteral(resourceName: "nigeria")),
    ("NIO", "Nicaraguan Córdoba", "C$", #imageLiteral(resourceName: "nicaragua")),
    ("NOK", "Norwegian Krone", "kr", #imageLiteral(resourceName: "norway")),
    ("NPR", "Nepalese Rupee", "₨", #imageLiteral(resourceName: "nepal")),
    ("NZD", "New Zealand Dollar", "$", #imageLiteral(resourceName: "new-zealand")),
    ("OMR", "Omani Rial", "ر.ع.", #imageLiteral(resourceName: "oman")),
    ("PAB", "Panamanian Balboa", "B/.", #imageLiteral(resourceName: "panama")),
    ("PEN", "Peruvian Nuevo Sol", "S/.", #imageLiteral(resourceName: "panama")),
    ("PGK", "Papua New Guinean Kina", "K", #imageLiteral(resourceName: "papua-new-guinea")),
    ("PHP", "Philippine Peso", "₱", #imageLiteral(resourceName: "philippines")),
    ("PKR", "Pakistani Rupee", "₨", #imageLiteral(resourceName: "pakistan")),
    ("PLN", "Polish Zloty", "zł", #imageLiteral(resourceName: "republic-of-poland")),
    ("PYG", "Paraguayan Guarani", "₲", #imageLiteral(resourceName: "paraguay")),
    ("QAR", "Qatari Rial", "ر.ق", #imageLiteral(resourceName: "qatar")),
    ("RON", "Romanian Leu", "L", #imageLiteral(resourceName: "romania")),
    ("RSD", "Serbian Dinar", "din", #imageLiteral(resourceName: "serbia")),
    ("RUB", "Russian Ruble", "р.", #imageLiteral(resourceName: "russia")),
    ("RWF", "Rwandan Franc", "₣", #imageLiteral(resourceName: "rwanda")),
    ("SAR", "Saudi Riyal", "ر.س", #imageLiteral(resourceName: "saudi-arabia")),
    ("SBD", "Solomon Islands Dollar", "$", #imageLiteral(resourceName: "solomon-islands")),
    ("SCR", "Seychellois Rupee", "₨", #imageLiteral(resourceName: "seychelles")),
    ("SDG", "Sudanese Pound", "£", #imageLiteral(resourceName: "sudan")),
    ("SEK", "Swedish Krona", "kr", #imageLiteral(resourceName: "sweden")),
    ("SGD", "Singapore Dollar", "$", #imageLiteral(resourceName: "singapore")),
    ("SHP", "Saint Helena Pound", "£", #imageLiteral(resourceName: "united-kingdom")),
    ("SLL", "Sierra Leonean Leone", "Le", #imageLiteral(resourceName: "sierra-leone")),
    ("SOS", "Somali Shilling", "Sh", #imageLiteral(resourceName: "somalia")),
    ("SRD", "Surinamese Dollar", "$", #imageLiteral(resourceName: "suriname")),
    ("STD", "São Tomé and Príncipe Dobra", "Db", #imageLiteral(resourceName: "sao-tome-and-principe")),
    ("SVC", "Salvadoran Colón", "₡", #imageLiteral(resourceName: "salvador")),
    ("SYP", "Syrian Pound", "ل.س", #imageLiteral(resourceName: "syria")),
    ("SZL", "Swazi Lilangeni", "L", #imageLiteral(resourceName: "swaziland")),
    ("THB", "Thai Baht", "฿", #imageLiteral(resourceName: "thailand")),
    ("TJS", "Tajikistani Somoni", "ЅМ", #imageLiteral(resourceName: "tajikistan")),
    ("TMT", "Turkmenistani Manat", "m", #imageLiteral(resourceName: "turkmenistan")),
    ("TND", "Tunisian Dinar", "د.ت", #imageLiteral(resourceName: "tunisia")),
    ("TOP", "Tongan Paʻanga", "T$", #imageLiteral(resourceName: "tonga")),
    ("TRY", "Turkish Lira", "₤", #imageLiteral(resourceName: "turkey")),
    ("TTD", "Trinidad and Tobago Dollar", "$", #imageLiteral(resourceName: "trinidad-and-tobago")),
    ("TWD", "Taiwan Dollar", "$", #imageLiteral(resourceName: "taiwan")),
    ("TZS", "Tanzanian Shilling", "Sh", #imageLiteral(resourceName: "tanzania")),
    ("UAH", "Ukrainian Hryvnia", "₴", #imageLiteral(resourceName: "ukraine")),
    ("UGX", "Ugandan Shilling", "Sh", #imageLiteral(resourceName: "uganda")),
    ("USD", "United States Dollars", "$", #imageLiteral(resourceName: "united-states-of-america")),
    ("UYU", "Uruguayan Peso", "$", #imageLiteral(resourceName: "uruguay")),
    ("UZS", "Uzbekistan Som", "лв", #imageLiteral(resourceName: "uzbekistn")),
    ("VEF", "Venezuelan Bolívar Fuerte", "Bs.", #imageLiteral(resourceName: "uzbekistn")),
    ("VND", "Vietnamese Dong", "₫", #imageLiteral(resourceName: "vietnam")),
    ("VUV", "Vanuatu Vatu", "Vt", #imageLiteral(resourceName: "vanuatu")),
    ("WST", "Samoan Tala", "T", #imageLiteral(resourceName: "samoa")),
    ("XAF", "CFA Franc BEAC", "₣", #imageLiteral(resourceName: "central-african-republic")),
    ("XCD", "East Caribbean Dollar", "$", #imageLiteral(resourceName: "grenada")),
    ("XOF", "CFA Franc BCEAO", "$", #imageLiteral(resourceName: "senegal")),
    ("XPF", "CFP Franc", "₣", #imageLiteral(resourceName: "french-polynesia")),
    ("YER", "Yemeni Rial", "﷼", #imageLiteral(resourceName: "yemen")),
    ("ZAR", "South African Rand", "R", #imageLiteral(resourceName: "south-africa")),
    ("ZMW", "Zambian Kwacha", "ZK", #imageLiteral(resourceName: "zambia")),
    ("ZWL", "Zimbabwean Dollar", "$", #imageLiteral(resourceName: "zimbabwe"))
  ].sorted(by: {$0.1 < $1.1})
}
