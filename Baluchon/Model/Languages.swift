//
//  Languages.swift
//  Baluchon
//
//  Created by Roland Lariotte on 02/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import UIKit

typealias LanguageTuple = (code: String, language: String, flag: UIImage)
// Structure to manage the worldLanguages in picker Views
struct Languages {
  var top: LanguageTuple
  var Bottom: LanguageTuple
}

struct TranslationResult {
  var result: String
}

// Structures that get the data after the API call
struct LanguageRoot: Decodable {
  var data: Translations
}

struct Translations: Decodable {
  let translations: [TranslatedText]
}

struct TranslatedText: Decodable {
  let translatedText: String
}

class WorldLanguages {
  let worldLanguages: [LanguageTuple] = [
    ("fr", "French", #imageLiteral(resourceName: "france")),
    ("en", "English", #imageLiteral(resourceName: "united-kingdom")),
    ("af", "Afrikaans", #imageLiteral(resourceName: "south-africa")),
    ("sq", "Albanian", #imageLiteral(resourceName: "albania")),
    ("am", "Amharic", #imageLiteral(resourceName: "ethiopia")),
    ("ar", "Arabic", #imageLiteral(resourceName: "united-arab-emirates")),
    ("hy", "Armenian", #imageLiteral(resourceName: "armenia")),
    ("az", "Azerbaijani", #imageLiteral(resourceName: "azerbaijan")),
    ("eu", "Basque", #imageLiteral(resourceName: "basque-country")),
    ("be", "Belarusian", #imageLiteral(resourceName: "belarus")),
    ("bn", "Bengali", #imageLiteral(resourceName: "bangladesh")),
    ("bs", "Bosnian", #imageLiteral(resourceName: "bosnia-and-herzegovina")),
    ("bg", "Bulgarian", #imageLiteral(resourceName: "bulgaria")),
    ("ca", "Catalan", #imageLiteral(resourceName: "spain")),
    ("ceb", "Cebuano", #imageLiteral(resourceName: "philippines")),
    ("zh-CN", "Chinese (Simplified)", #imageLiteral(resourceName: "china")),
    ("zh-TW", "Chinese (Traditional)", #imageLiteral(resourceName: "china")),
    ("co", "Corsican", #imageLiteral(resourceName: "corsica")),
    ("hr", "Croatian", #imageLiteral(resourceName: "croatia")),
    ("cs", "Czech", #imageLiteral(resourceName: "czech-republic")),
    ("da", "Danish", #imageLiteral(resourceName: "denmark")),
    ("nl", "Dutch", #imageLiteral(resourceName: "netherlands")),
    ("en", "English", #imageLiteral(resourceName: "united-kingdom")),
    ("eo", "Esperanto", #imageLiteral(resourceName: "nigeria")),
    ("et", "Estonian", #imageLiteral(resourceName: "estonia")),
    ("fi", "Finnish", #imageLiteral(resourceName: "finland")),
    ("fr", "French", #imageLiteral(resourceName: "france")),
    ("fy", "Frisian", #imageLiteral(resourceName: "netherlands")),
    ("gl", "Galician", #imageLiteral(resourceName: "spain")),
    ("ka", "Georgian", #imageLiteral(resourceName: "georgia")),
    ("de", "German", #imageLiteral(resourceName: "germany")),
    ("el", "Greek", #imageLiteral(resourceName: "greece")),
    ("gu", "Gujarati", #imageLiteral(resourceName: "india")),
    ("ht", "Haitian Creole", #imageLiteral(resourceName: "haiti")),
    ("ha", "Hausa", #imageLiteral(resourceName: "nigeria")),
    ("haw", "Hawaiian", #imageLiteral(resourceName: "hawaii")),
    ("he", "Hebrew", #imageLiteral(resourceName: "israel")),
    ("hi", "Hindi", #imageLiteral(resourceName: "india")),
    ("hmn", "Hmong", #imageLiteral(resourceName: "spain")),
    ("hu", "Hungarian", #imageLiteral(resourceName: "hungary")),
    ("is", "Icelandic", #imageLiteral(resourceName: "iceland")),
    ("ig", "Igbo", #imageLiteral(resourceName: "nigeria")),
    ("id", "Indonesian", #imageLiteral(resourceName: "indonesia")),
    ("ga", "Irish", #imageLiteral(resourceName: "ireland")),
    ("it", "Italian", #imageLiteral(resourceName: "italy")),
    ("ja", "Japanese", #imageLiteral(resourceName: "japan")),
    ("jw", "Javanese", #imageLiteral(resourceName: "indonesia")),
    ("kn", "Kannada", #imageLiteral(resourceName: "india")),
    ("kk", "Kazakh", #imageLiteral(resourceName: "kazakhstan")),
    ("km", "Khmer", #imageLiteral(resourceName: "cambodia")),
    ("ko", "Korean", #imageLiteral(resourceName: "south-korea")),
    ("ku", "Kurdish", #imageLiteral(resourceName: "iran")),
    ("ky", "Kyrgyz", #imageLiteral(resourceName: "kyrgyzstan")),
    ("lo", "Lao", #imageLiteral(resourceName: "laos")),
    ("la", "Latin", #imageLiteral(resourceName: "italy")),
    ("lv", "Latvian", #imageLiteral(resourceName: "latvia")),
    ("lt", "Lithuanian", #imageLiteral(resourceName: "lithuania")),
    ("lb", "Luxembourgish", #imageLiteral(resourceName: "luxembourg")),
    ("mk", "Macedonian", #imageLiteral(resourceName: "republic-of-macedonia")),
    ("mg", "Malagasy", #imageLiteral(resourceName: "madagascar")),
    ("ms", "Malay", #imageLiteral(resourceName: "malaysia")),
    ("ml", "Malayalam", #imageLiteral(resourceName: "india")),
    ("mt", "Maltese", #imageLiteral(resourceName: "malta")),
    ("mi", "Maori", #imageLiteral(resourceName: "new-zealand")),
    ("mr", "Marathi", #imageLiteral(resourceName: "india")),
    ("mn", "Mongolian", #imageLiteral(resourceName: "mongolia")),
    ("my", "Myanmar (Burmese)", #imageLiteral(resourceName: "myanmar")),
    ("ne", "Nepali", #imageLiteral(resourceName: "nepal")),
    ("no", "Norwegian", #imageLiteral(resourceName: "norway")),
    ("ny", "Nyanja (Chichewa)", #imageLiteral(resourceName: "zambia")),
    ("ps", "Pashto", #imageLiteral(resourceName: "iran")),
    ("fa", "Persian", #imageLiteral(resourceName: "iran")),
    ("pl", "Polish", #imageLiteral(resourceName: "republic-of-poland")),
    ("pt", "Portuguese", #imageLiteral(resourceName: "portugal")),
    ("pa", "Punjabi", #imageLiteral(resourceName: "pakistan")),
    ("ro", "Romanian", #imageLiteral(resourceName: "romania")),
    ("ru", "Russian", #imageLiteral(resourceName: "russia")),
    ("sm", "Samoan", #imageLiteral(resourceName: "samoa")),
    ("gd", "Scots Gaelic", #imageLiteral(resourceName: "scotland")),
    ("sr", "Serbian", #imageLiteral(resourceName: "serbia")),
    ("st", "Sesotho", #imageLiteral(resourceName: "south-africa")),
    ("sn", "Shona", #imageLiteral(resourceName: "zimbabwe")),
    ("sd", "Sindhi", #imageLiteral(resourceName: "india")),
    ("si", "Sinhala (Sinhalese)", #imageLiteral(resourceName: "sri-lanka")),
    ("sk", "Slovak", #imageLiteral(resourceName: "slovakia")),
    ("sl", "Slovenian", #imageLiteral(resourceName: "slovenia")),
    ("so", "Somali", #imageLiteral(resourceName: "somalia")),
    ("es", "Spanish", #imageLiteral(resourceName: "spain")),
    ("su", "Sundanese", #imageLiteral(resourceName: "sudan")),
    ("sw", "Swahili", #imageLiteral(resourceName: "tanzania")),
    ("sv", "Swedish", #imageLiteral(resourceName: "sweden")),
    ("tl", "Tagalog (Filipino)", #imageLiteral(resourceName: "philippines")),
    ("tg", "Tajik", #imageLiteral(resourceName: "tajikistan")),
    ("ta", "Tamil", #imageLiteral(resourceName: "india")),
    ("te", "Telugu", #imageLiteral(resourceName: "india")),
    ("th", "Thai", #imageLiteral(resourceName: "thailand")),
    ("tr", "Turkish", #imageLiteral(resourceName: "turkey")),
    ("uk", "Ukrainian", #imageLiteral(resourceName: "ukraine")),
    ("ur", "Urdu", #imageLiteral(resourceName: "pakistan")),
    ("uz", "Uzbek", #imageLiteral(resourceName: "uzbekistn")),
    ("vi", "Vietnamese", #imageLiteral(resourceName: "vietnam")),
    ("cy", "Welsh", #imageLiteral(resourceName: "wales")),
    ("xh", "Xhosa", #imageLiteral(resourceName: "south-africa")),
    ("yi", "Yiddish", #imageLiteral(resourceName: "israel")),
    ("yo", "Yoruba", #imageLiteral(resourceName: "nigeria")),
    ("zu", "Zulu", #imageLiteral(resourceName: "south-africa"))
  ]
}
