//
//  APIRuler.swift
//  Baluchon
//
//  Created by Roland Lariotte on 25/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

class APIsRuler {
  static var shared = APIsRuler()
  private init() {}

  // ExchangeRate API URL
  private static let exchangeURL = URL(
    string: "https://data.fixer.io/api/convert")!
  private static let exchangeAPI = valueForAPIKey(
    named: "myExchangeRateAPIKey")
  // Translator API URL
  private static let translationURL = URL(
    string: "https://translation.googleapis.com/language/translate/v2/")!
  private static let translationAPI = valueForAPIKey(
    named: "myGoogleTranslateAPIKey")
  // WeatherForecast API URL
  private static let weatherURL = URL(
    string: "http://openweathermap.org/data/2.5/weather")!
  private static let weatherAPI = valueForAPIKey(
    named: "myOpenWeatherAPIKey")

  private var task: URLSessionDataTask?
  private var session = URLSession(configuration: .default)

  init(session: URLSession) {
    self.session = session
  }
}

//MARK: - Method for the user to swap elements
extension APIsRuler {
  func swapElements<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
  }
}

//MARK: - Networking the exchange rate user input data
extension APIsRuler {
  func getExchangeRate(from: String, to: String, amount: String, callback: @escaping (Bool, ConversionResult?) -> Void) {
    let fullURL = APIsRuler.exchangeURL.absoluteString + "?access_key=\(APIsRuler.exchangeAPI)&from=\(from)&to=\(to)&amount=\(amount)"
    var request = URLRequest(url: URL(string: fullURL)!)
    request.httpMethod = "GET"

    task?.cancel()
    task = session.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data, error == nil else {
          return callback(false, nil)
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          return callback(false, nil)
        }
        do {
          let responseJSON = try JSONDecoder().decode(ExchangeRoot.self, from: data)
          let conversionResult = ConversionResult(
            exchangeRate: responseJSON.info.rate,
            exchangeResult: responseJSON.result)
          callback(true, conversionResult)
        }
        catch {
          return callback(false, nil)
        }
      }
    }
    task?.resume()
  }
}

//MARK: - Networking the translator user input data
extension APIsRuler {
  func getTranslation(q: String, source: String, target: String, callback: @escaping (Bool, String?) -> Void) {
    let encodeUserEntry = q.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    let fullURL = APIsRuler.translationURL.absoluteString + "?q=\(encodeUserEntry!)&source=\(source)&target=\(target)&key=\(APIsRuler.translationAPI)"
    var request = URLRequest(url: URL(string: fullURL)!)
    request.httpMethod = "GET"

    task?.cancel()
    task = session.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data, error == nil else {
          return callback(false, nil)
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          return callback(false, nil)
        }
        do {
          let responseJSON = try JSONDecoder().decode(LanguageRoot.self, from: data)
          let translationResult = responseJSON.data.translations[0].translatedText
          callback(true, translationResult)
        }
        catch {
          return callback(false, nil)
        }
      }
    }
    task?.resume()
  }
}

//MARK: - Networking the weather user latitude and longitude data
extension APIsRuler {
  func getLatLongForecast(lat: String, lon: String, callback: @escaping (Bool, WeatherResult?) -> Void ) {
    let fullURL = APIsRuler.weatherURL.absoluteString + "?lat=\(lat)&lon=\(lon)&appid=\(APIsRuler.weatherAPI)"
    var request = URLRequest(url: URL(string: fullURL)!)
    request.httpMethod = "GET"

    task = session.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data, error == nil else {
          return callback(false, nil)
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          return callback(false, nil)
        }
        do {
          let responseJSON = try JSONDecoder().decode(WeatherRoot.self, from: data)
          let weatherLatLonResult = WeatherResult(
            temperature: responseJSON.main.temp,
            city: responseJSON.name,
            weatherCondition: updateWeatherIcon(condition: responseJSON.weather[0].id))
          callback(true, weatherLatLonResult)
        }
        catch {
          return callback(false, nil)
        }
      }
    }
    task?.resume()
  }
}

//MARK: - Networking the weather user city data
extension APIsRuler {
  func getCityForecast(city: String, callback: @escaping (Bool, WeatherResult?) -> Void ) {
    let fullURL = APIsRuler.weatherURL.absoluteString + "?q=\(city)&appid=\(APIsRuler.weatherAPI)"
    var request = URLRequest(url: URL(string: fullURL)!)
    request.httpMethod = "GET"

    task = session.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data, error == nil else {
          return callback(false, nil)
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          return callback(false, nil)
        }
        do {
          let responseJSON = try JSONDecoder().decode(WeatherRoot.self, from: data)
          let weatherCityResult = WeatherResult(
            temperature: responseJSON.main.temp,
            city: responseJSON.name,
            weatherCondition: updateWeatherIcon(condition: responseJSON.weather[0].id))
          callback(true, weatherCityResult)
        }
        catch {
          return callback(false, nil)
        }
      }
    }
    task?.resume()
  }
}
