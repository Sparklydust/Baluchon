//
//  getCityForecastTestCase.swift
//  BaluchonTests
//
//  Created by Roland Lariotte on 18/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Baluchon
import XCTest

class GetCityForecastTestCase: XCTestCase {
  func testGetCityShouldPostFailedCallbackIfError() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getCityForecast(city: "Marseille") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetCityShouldPostFailedCallbackIfNoData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getCityForecast(city: "Marseille") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetCityShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.cityForecastCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getCityForecast(city: "Marseille") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetCityShouldPostFailedCallbackIfIncorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.APIsRulerIncorrectData, response: FakeResponseData.responseOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getCityForecast(city: "Marseille") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetCityShouldPostSuccessCallbackAndCorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.cityForecastCorrectData, response: FakeResponseData.responseOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getCityForecast(city: "Marseille") { (success, WeatherResult) in
      // Then
      let city = "Marseille"
      let temperature = 13.95
      let weatherCondition = "sun"
      
      XCTAssertTrue(success)
      XCTAssertNotNil(WeatherResult?.city)
      XCTAssertNotNil(WeatherResult?.temperature)
      XCTAssertNotNil(WeatherResult?.weatherCondition)
      XCTAssertEqual(city, WeatherResult!.city)
      XCTAssertEqual(temperature, WeatherResult!.temperature)
      XCTAssertEqual(weatherCondition, WeatherResult!.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}
