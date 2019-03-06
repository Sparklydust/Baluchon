//
//  Languages.swift
//  Baluchon
//
//  Created by Roland Lariotte on 02/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import UIKit

typealias LanguageTuple = (language: String, flag: UIImage)

struct Languages {
  var top: LanguageTuple
  var Bottom: LanguageTuple
}

let worldLanguages: [LanguageTuple] = [
  ("French", #imageLiteral(resourceName: "france")),
  ("English", #imageLiteral(resourceName: "united-kingdom")),
  ("German", #imageLiteral(resourceName: "germany"))
]
