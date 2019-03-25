//
//  APIKeys.swift
//  Baluchon
//
//  Created by Roland Lariotte on 15/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

// Method that gets the .gitignore API Keys from .plist 
func valueForAPIKey(named keyname: String) -> String {
  let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist")
  let plist = NSDictionary(contentsOfFile: filePath!)
  let value = plist?.object(forKey: keyname) as! String
  return value
}
