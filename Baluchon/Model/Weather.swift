//
//  WeatherDataModel.swift
//  Baluchon
//
//  Created by Roland Lariotte on 04/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

// Structures that get the data after the API call
struct WeatherRoot: Decodable {
  let weather: [Weather]
  let main: Main
  let name: String
}

struct Main: Decodable {
  let temp: Double
}
struct Weather: Decodable {
  let id: Int
}

struct WeatherResult {
  var temperature: Double
  var city: String
  var weatherCondition: String
}

// Turns a condition code into the name of the weather condition image
func updateWeatherIcon(condition: Int) -> String {
  switch (condition) {
  case 200...232:
    return "storm"
  case 301...311:
    return "rain-1"
  case 312...321:
    return "rain-2"
  case 500...531 :
    return "rain"
  case 600:
    return "snowflake"
  case 601:
    return "snowing-2"
  case 602:
    return "snowing-3"
  case 611...616:
    return "snowing-1"
  case 620...621:
    return "snowing-3"
  case 622:
    return "winter"
  case 701...771 :
    return "cloud"
  case 772...780 :
    return "storm"
  case 781:
    return "tornado"
  case 800 :
    return "sun"
  case 801:
    return "cloudy-1"
  case 802:
    return "cloudy"
  case 803...804:
    return "cloud"
  default :
    return "dunno"
  }
}
