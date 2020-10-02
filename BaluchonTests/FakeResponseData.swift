//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Roland Lariotte on 18/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

class FakeResponseData {
  static let responseOK = HTTPURLResponse(
    url: URL(string: "https://www.openclassrooms.com")!,
    statusCode: 200, httpVersion: nil, headerFields: nil)!
  static let responseKO = HTTPURLResponse(
    url: URL(string: "https://www.openclassrooms.com")!,
    statusCode: 500, httpVersion: nil, headerFields: nil)!
  
  static let APIsRulerIncorrectData = "erreur".data(using: .utf8)!

  static var exchangeCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  static var translatorCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let url = bundle.url(forResource: "Translator", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  static var latLongForecastCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let url = bundle.url(forResource: "LatLongForecast", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  static var cityForecastCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let url = bundle.url(forResource: "CityForecast", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }
  
  
  class APIsRulerError: Error {}
  static let error = APIsRulerError()
}
