//
//  APIRuler.swift
//  Baluchon
//
//  Created by Roland Lariotte on 25/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

class APIsRuler {
  
  private static let exchangeURL = URL(string: "")
  
  // Method to swap elements
  func swapElements<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
  }
}
