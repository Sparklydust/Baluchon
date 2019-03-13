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
]
