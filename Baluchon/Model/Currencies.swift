//
//  Currency.swift
//  Baluchon
//
//  Created by Roland Lariotte on 01/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import UIKit

typealias CurrencyTuple = (
  symbol: String, name: String, sign: String, flag: UIImage, country: String)
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
    ("AED", "United Arab Emirates Dirham", "د.إ", #imageLiteral(resourceName: "united-arab-emirates"), "united-arab-emirates.png"),
    ("AFN", "Afghan Afghani", "Af", #imageLiteral(resourceName: "afghanistan"), "afghanistan.png"),
    ("ALL", "Albanian Lek", "L", #imageLiteral(resourceName: "albania"), "albania.png"),
    ("AMD", "Armenian Dram", "Դ", #imageLiteral(resourceName: "armenia"), "armenia.png"),
    ("ANG", "Netherlands Antillean Guilder", "ƒ", #imageLiteral(resourceName: "curacao"), "curacao.png"),
    ("AOA", "Angolan Kwanza", "Kz", #imageLiteral(resourceName: "angola"), "angola.png"),
    ("ARS", "Argentine Peso", "$", #imageLiteral(resourceName: "argentina"), "argentina.png"),
    ("AUD", "Australian Dollar", "$", #imageLiteral(resourceName: "australia"), "australia.png"),
    ("AWG", "Aruban Florin", "ƒ", #imageLiteral(resourceName: "aruba"), "aruba.png"),
    ("AZN", "Azerbaijani Manat", "ман", #imageLiteral(resourceName: "azerbaijan"), "azerbaijan.png"),
    ("BAM", "Bosnia-Herzegovina Convertible Mark", "КМ", #imageLiteral(resourceName: "bosnia-and-herzegovina"), "bosnia-and-herzegovina.png"),
    ("BBD", "Barbadian Dollar", "$", #imageLiteral(resourceName: "barbados"), "barbados.png"),
    ("BDT", "Bangladeshi Taka", "৳", #imageLiteral(resourceName: "bangladesh"), "bangladesh.png"),
    ("BGN", "Bulgarian Lev", "лв", #imageLiteral(resourceName: "bulgaria"), "bulgaria.png"),
    ("BHD", "Bahraini Dinar", "ب.د", #imageLiteral(resourceName: "bahrain"), "bahrain.png"),
    ("BIF", "Burundian Franc", "₣", #imageLiteral(resourceName: "burundi"), "burundi.png"),
    ("BMD", "Bermudan Dollar", "$", #imageLiteral(resourceName: "bermuda"), "bermuda.png"),
    ("BND", "Brunei Dollar", "$", #imageLiteral(resourceName: "brunei"), "brunei.png"),
    ("BOB", "Bolivian Boliviano", "Bs.", #imageLiteral(resourceName: "bolivia"), "bolivia.png"),
    ("BRL", "Brazilian Real", "R$", #imageLiteral(resourceName: "brazil"), "brazil.png"),
    ("BSD", "Bahamian Dollar", "$", #imageLiteral(resourceName: "bahamas"), "bahamas.png"),
    ("BTC", "Bitcoin", "₿", #imageLiteral(resourceName: "bitcoin"), "bitcoin.png"),
    ("BTN", "Bhutanese Ngultrum", "Nu.", #imageLiteral(resourceName: "bhutan"), "bhutan.png"),
    ("BWP", "Botswanan Pula", "P", #imageLiteral(resourceName: "botswana"), "botswana.png"),
    ("BYR", "Belarusian Ruble", "Br", #imageLiteral(resourceName: "belarus"), "belarus.png"),
    ("BZD", "Belize Dollar", "$", #imageLiteral(resourceName: "belize"), "belize.png"),
    ("CAD", "Canadian Dollar", "$", #imageLiteral(resourceName: "canada"), "canada.png"),
    ("CDF", "Congolese Franc", "₣", #imageLiteral(resourceName: "republic-of-the-congo"), "republic-of-the-congo.png"),
    ("CHF", "Swiss Franc", "₣", #imageLiteral(resourceName: "switzerland"), "switzerland.png"),
    ("CLF", "Chilean Unit of Account (UF)", "$", #imageLiteral(resourceName: "chile"), "chile.png"),
    ("CLP", "Chilean Peso", "$", #imageLiteral(resourceName: "chile"), "chile.png"),
    ("CNY", "Chinese Yuan", "¥", #imageLiteral(resourceName: "china"), "china.png"),
    ("COP", "Colombian Peso", "$", #imageLiteral(resourceName: "colombia"), "colombia.png"),
    ("CRC", "Costa Rican Colón", "₡", #imageLiteral(resourceName: "costa-rica"), "costa-rica.png"),
    ("CUC", "Cuban Convertible Peso", "$", #imageLiteral(resourceName: "cuba"), "cuba.png"),
    ("CUP", "Cuban Peso", "$", #imageLiteral(resourceName: "cuba"), "cuba.png"),
    ("CVE", "Cape Verdean Escudo", "$", #imageLiteral(resourceName: "cape-verde"), "cape-verde.png"),
    ("CZK", "Czech Republic Koruna", "Kč", #imageLiteral(resourceName: "czech-republic"), "czech-republic.png"),
    ("DJF", "Djiboutian Franc", "₣", #imageLiteral(resourceName: "djibouti"), "djibouti.png"),
    ("DKK", "Danish Krone", "kr", #imageLiteral(resourceName: "denmark"), "denmark.png"),
    ("DOP", "Dominican Peso", "$", #imageLiteral(resourceName: "dominican-republic"), "dominican-republic.png"),
    ("DZD", "Algerian Dinar", "د.ج", #imageLiteral(resourceName: "algeria"), "algeria.png"),
    ("EGP", "Egyptian Pound", "£", #imageLiteral(resourceName: "egypt"), "egypt.png"),
    ("ERN", "Eritrean Nakfa", "Nfk", #imageLiteral(resourceName: "eritrea"), "eritrea.png"),
    ("ETB", "Ethiopian Birr", "ብር", #imageLiteral(resourceName: "ethiopia"), "ethiopia.png"),
    ("EUR", "Euro", "€", #imageLiteral(resourceName: "european-union"), "european-union.png"),
    ("FJD", "Fijian Dollar", "$", #imageLiteral(resourceName: "fiji"), "fiji.png"),
    ("FKP", "Falkland Islands Pound", "£", #imageLiteral(resourceName: "falkland-islands"), "falkland-islands.png"),
    ("GBP", "British Pound Sterling", "£", #imageLiteral(resourceName: "united-kingdom"), "united-kingdom.png"),
    ("GEL", "Georgian Lari", "ლ", #imageLiteral(resourceName: "georgia"), "georgia.png"),
    ("GGP", "Guernsey Pound", "£", #imageLiteral(resourceName: "guernsey"), "guernsey.png"),
    ("GHS", "Ghanaian Cedi", "₵", #imageLiteral(resourceName: "ghana"), "ghana.png"),
    ("GIP", "Gibraltar Pound", "£", #imageLiteral(resourceName: "gibraltar"), "gibraltar.png"),
    ("GMD", "Gambian Dalasi", "D", #imageLiteral(resourceName: "gambia"), "gambia.png"),
    ("GNF", "Guinean Franc", "₣", #imageLiteral(resourceName: "guinea"), "guinea.png"),
    ("GTQ", "Guatemalan Quetzal", "Q", #imageLiteral(resourceName: "guatemala"), "guatemala.png"),
    ("GYD", "Guyanaese Dollar", "$", #imageLiteral(resourceName: "guyana"), "guyana.png"),
    ("HKD", "Hong Kong Dollar", "$", #imageLiteral(resourceName: "hong-kong"), "hong-kong.png"),
    ("HNL", "Honduran Lempira", "L", #imageLiteral(resourceName: "honduras"), "honduras.png"),
    ("HRK", "Croatian Kuna", "Kn", #imageLiteral(resourceName: "croatia"), "croatia.png"),
    ("HTG", "Haitian Gourde", "G", #imageLiteral(resourceName: "haiti"), "haiti.png"),
    ("HUF", "Hungarian Forint", "Ft", #imageLiteral(resourceName: "hungary"), "hungary.png"),
    ("IDR", "Indonesian Rupiah", "Rp", #imageLiteral(resourceName: "indonesia"), "indonesia.png"),
    ("ILS", "Israeli New Sheqel", "₪", #imageLiteral(resourceName: "israel"), "israel.png"),
    ("IMP", "Manx pound", "£", #imageLiteral(resourceName: "isle-of-man"), "isle-of-man.png"),
    ("INR", "Indian Rupee", "₹", #imageLiteral(resourceName: "india"), "india.png"),
    ("IQD", "Iraqi Dinar", "ع.د", #imageLiteral(resourceName: "iraq"), "iraq.png"),
    ("IRR", "Iranian Rial", "﷼", #imageLiteral(resourceName: "iran"), "iran.png"),
    ("ISK", "Icelandic Króna", "Kr", #imageLiteral(resourceName: "iceland"), "iceland.png"),
    ("JEP", "Jersey Pound", "£", #imageLiteral(resourceName: "jersey"), "jersey.png"),
    ("JMD", "Jamaican Dollar", "$", #imageLiteral(resourceName: "jamaica"), "jamaica.png"),
    ("JOD", "Jordanian Dinar", "د.ا", #imageLiteral(resourceName: "jordan"), "jordan.png"),
    ("JPY", "Japanese Yen", "¥", #imageLiteral(resourceName: "japan"), "japan.png"),
    ("KES", "Kenyan Shilling", "Sh", #imageLiteral(resourceName: "kenya"), "kenya.png"),
    ("KGS", "Kyrgystani Som", "Лв", #imageLiteral(resourceName: "kyrgyzstan"), "kyrgyzstan.png"),
    ("KHR", "Cambodian Riel", "៛", #imageLiteral(resourceName: "cambodia"), "cambodia.png"),
    ("KMF", "Comorian Franc", "CF", #imageLiteral(resourceName: "comoros"), "comoros.png"),
    ("KPW", "North Korean Won", "₩", #imageLiteral(resourceName: "north-korea"), "north-korea.png"),
    ("KRW", "South Korean Won", "₩", #imageLiteral(resourceName: "south-korea"), "south-korea.png"),
    ("KWD", "Kuwaiti Dinar", "د.ك", #imageLiteral(resourceName: "kuwait"), "kuwait.png"),
    ("KYD", "Cayman Islands Dollar", "$", #imageLiteral(resourceName: "cayman-islands"), "cayman-islands.png"),
    ("KZT", "Kazakhstani Tenge", "〒", #imageLiteral(resourceName: "kazakhstan"), "kazakhstan.png"),
    ("LAK", "Laotian Kip", "₭", #imageLiteral(resourceName: "laos"), "laos.png"),
    ("LBP", "Lebanese Pound", "ل.ل", #imageLiteral(resourceName: "lebanon"), "lebanon.png"),
    ("LKR", "Sri Lankan Rupee", "Rs", #imageLiteral(resourceName: "sri-lanka"), "sri-lanka.png"),
    ("LRD", "Liberian Dollar", "$", #imageLiteral(resourceName: "liberia"), "liberia.png"),
    ("LSL", "Lesotho Loti", "L", #imageLiteral(resourceName: "lesotho"), "lesotho.png"),
    ("LYD", "Libyan Dinar", "ل.د", #imageLiteral(resourceName: "libya"), "libya.png"),
    ("MAD", "Moroccan Dirham", "د.م.", #imageLiteral(resourceName: "morocco"), "morocco.png"),
    ("MDL", "Moldovan Leu", "L", #imageLiteral(resourceName: "moldova"), "moldova.png"),
    ("MGA", "Malagasy Ariary", "Ar", #imageLiteral(resourceName: "madagascar"), "madagascar.png"),
    ("MKD", "Macedonian Denar", "ден", #imageLiteral(resourceName: "republic-of-macedonia"), "republic-of-macedonia.png"),
    ("MMK", "Myanma Kyat", "K", #imageLiteral(resourceName: "myanmar"), "myanmar.png"),
    ("MNT", "Mongolian Tugrik", "₮", #imageLiteral(resourceName: "mongolia"), "mongolia.png"),
    ("MOP", "Macanese Pataca", "P", #imageLiteral(resourceName: "macao"), "macao.png"),
    ("MRO", "Mauritanian Ouguiya", "UM", #imageLiteral(resourceName: "mauritania"), "mauritania.png"),
    ("MUR", "Mauritian Rupee", "₨", #imageLiteral(resourceName: "mauritius"), "mauritius.png"),
    ("MVR", "Maldivian Rufiyaa", "ރ.", #imageLiteral(resourceName: "maldives"), "maldives.png"),
    ("MWK", "Malawian Kwacha", "MK", #imageLiteral(resourceName: "malawi"), "malawi.png"),
    ("MXN", "Mexican Peso", "$", #imageLiteral(resourceName: "mexico"), "mexico.png"),
    ("MYR", "Malaysian Ringgit", "RM", #imageLiteral(resourceName: "malaysia"), "malaysia.png"),
    ("MZN", "Mozambican Metical", "MTn", #imageLiteral(resourceName: "mozambique"), "mozambique.png"),
    ("NAD", "Namibian Dollar", "$", #imageLiteral(resourceName: "namibia"), "namibia.png"),
    ("NGN", "Nigerian Naira", "₦", #imageLiteral(resourceName: "nigeria"), "nigeria.png"),
    ("NIO", "Nicaraguan Córdoba", "C$", #imageLiteral(resourceName: "nicaragua"), "nicaragua.png"),
    ("NOK", "Norwegian Krone", "kr", #imageLiteral(resourceName: "norway"), "norway.png"),
    ("NPR", "Nepalese Rupee", "₨", #imageLiteral(resourceName: "nepal"), "nepal.png"),
    ("NZD", "New Zealand Dollar", "$", #imageLiteral(resourceName: "new-zealand"), "new-zealand.png"),
    ("OMR", "Omani Rial", "ر.ع.", #imageLiteral(resourceName: "oman"), "oman.png"),
    ("PAB", "Panamanian Balboa", "B/.", #imageLiteral(resourceName: "panama"), "panama.png"),
    ("PEN", "Peruvian Nuevo Sol", "S/.", #imageLiteral(resourceName: "peru"), "peru.png"),
    ("PGK", "Papua New Guinean Kina", "K", #imageLiteral(resourceName: "papua-new-guinea"), "papua-new-guinea.png"),
    ("PHP", "Philippine Peso", "₱", #imageLiteral(resourceName: "philippines"), "philippines.png"),
    ("PKR", "Pakistani Rupee", "₨", #imageLiteral(resourceName: "pakistan"), "pakistan.png"),
    ("PLN", "Polish Zloty", "zł", #imageLiteral(resourceName: "republic-of-poland"), "republic-of-poland.png"),
    ("PYG", "Paraguayan Guarani", "₲", #imageLiteral(resourceName: "paraguay"), "paraguay.png"),
    ("QAR", "Qatari Rial", "ر.ق", #imageLiteral(resourceName: "qatar"), "qatar.png"),
    ("RON", "Romanian Leu", "L", #imageLiteral(resourceName: "romania"), "romania.png"),
    ("RSD", "Serbian Dinar", "din", #imageLiteral(resourceName: "serbia"), "serbia.png"),
    ("RUB", "Russian Ruble", "р.", #imageLiteral(resourceName: "russia"), "russia.png"),
    ("RWF", "Rwandan Franc", "₣", #imageLiteral(resourceName: "rwanda"), "rwanda.png"),
    ("SAR", "Saudi Riyal", "ر.س", #imageLiteral(resourceName: "saudi-arabia"), "saudi-arabia.png"),
    ("SBD", "Solomon Islands Dollar", "$", #imageLiteral(resourceName: "solomon-islands"), "solomon-islands.png"),
    ("SCR", "Seychellois Rupee", "₨", #imageLiteral(resourceName: "seychelles"), "seychelles.png"),
    ("SDG", "Sudanese Pound", "£", #imageLiteral(resourceName: "sudan"), "sudan.png"),
    ("SEK", "Swedish Krona", "kr", #imageLiteral(resourceName: "sweden"), "sweden.png"),
    ("SGD", "Singapore Dollar", "$", #imageLiteral(resourceName: "singapore"), "singapore.png"),
    ("SHP", "Saint Helena Pound", "£", #imageLiteral(resourceName: "united-kingdom"), "united-kingdom.png"),
    ("SLL", "Sierra Leonean Leone", "Le", #imageLiteral(resourceName: "sierra-leone"), "sierra-leone.png"),
    ("SOS", "Somali Shilling", "Sh", #imageLiteral(resourceName: "somalia"), "somalia.png"),
    ("SRD", "Surinamese Dollar", "$", #imageLiteral(resourceName: "suriname"), "suriname.png"),
    ("STD", "São Tomé and Príncipe Dobra", "Db", #imageLiteral(resourceName: "sao-tome-and-principe"), "sao-tome-and-principe.png"),
    ("SVC", "Salvadoran Colón", "₡", #imageLiteral(resourceName: "salvador"), "salvador.png"),
    ("SYP", "Syrian Pound", "ل.س", #imageLiteral(resourceName: "syria"), "syria.png"),
    ("SZL", "Swazi Lilangeni", "L", #imageLiteral(resourceName: "swaziland"), "swaziland.png"),
    ("THB", "Thai Baht", "฿", #imageLiteral(resourceName: "thailand"), "thailand.png"),
    ("TJS", "Tajikistani Somoni", "ЅМ", #imageLiteral(resourceName: "tajikistan"), "tajikistan.png"),
    ("TMT", "Turkmenistani Manat", "m", #imageLiteral(resourceName: "turkmenistan"), "turkmenistan.png"),
    ("TND", "Tunisian Dinar", "د.ت", #imageLiteral(resourceName: "tunisia"), "tunisia.png"),
    ("TOP", "Tongan Paʻanga", "T$", #imageLiteral(resourceName: "tonga"), "tonga.png"),
    ("TRY", "Turkish Lira", "₤", #imageLiteral(resourceName: "turkey"), "turkey.png"),
    ("TTD", "Trinidad and Tobago Dollar", "$", #imageLiteral(resourceName: "trinidad-and-tobago"), "trinidad-and-tobago.png"),
    ("TWD", "Taiwan Dollar", "$", #imageLiteral(resourceName: "taiwan"), "taiwan.png"),
    ("TZS", "Tanzanian Shilling", "Sh", #imageLiteral(resourceName: "tanzania"), "tanzania.png"),
    ("UAH", "Ukrainian Hryvnia", "₴", #imageLiteral(resourceName: "ukraine"), "ukraine.png"),
    ("UGX", "Ugandan Shilling", "Sh", #imageLiteral(resourceName: "uganda"), "uganda.png"),
    ("USD", "United States Dollars", "$", #imageLiteral(resourceName: "united-states-of-america"), "united-states-of-america.png"),
    ("UYU", "Uruguayan Peso", "$", #imageLiteral(resourceName: "uruguay"), "uruguay.png"),
    ("UZS", "Uzbekistan Som", "лв", #imageLiteral(resourceName: "uzbekistn"), "uzbekistn.png"),
    ("VEF", "Venezuelan Bolívar Fuerte", "Bs.", #imageLiteral(resourceName: "venezuela"), "venezuela.png"),
    ("VND", "Vietnamese Dong", "₫", #imageLiteral(resourceName: "vietnam"), "vietnam.png"),
    ("VUV", "Vanuatu Vatu", "Vt", #imageLiteral(resourceName: "vanuatu"), "vanuatu.png"),
    ("WST", "Samoan Tala", "T", #imageLiteral(resourceName: "samoa"), "samoa.png"),
    ("XAF", "CFA Franc BEAC", "₣", #imageLiteral(resourceName: "central-african-republic"), "central-african-republic.png"),
    ("XCD", "East Caribbean Dollar", "$", #imageLiteral(resourceName: "grenada"), "grenada.png"),
    ("XOF", "CFA Franc BCEAO", "$", #imageLiteral(resourceName: "senegal"), "senegal.png"),
    ("XPF", "CFP Franc", "₣", #imageLiteral(resourceName: "french-polynesia"), "french-polynesia.png"),
    ("YER", "Yemeni Rial", "﷼", #imageLiteral(resourceName: "yemen"), "yemen.png"),
    ("ZAR", "South African Rand", "R", #imageLiteral(resourceName: "south-africa"), "south-africa.png"),
    ("ZMW", "Zambian Kwacha", "ZK", #imageLiteral(resourceName: "zambia"), "zambia.png"),
    ("ZWL", "Zimbabwean Dollar", "$", #imageLiteral(resourceName: "zimbabwe"),"zimbabwe.png")
  ].sorted(by: {$0.1 < $1.1})
}
