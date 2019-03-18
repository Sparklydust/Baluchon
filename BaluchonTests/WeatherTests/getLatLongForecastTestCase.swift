//
//  getLatLongForecastTestCase.swift
//  BaluchonTests
//
//  Created by Roland Lariotte on 18/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Baluchon
import XCTest

class GetLatLongForecastTestCase: XCTestCase {
  func testGetLatLongShouldPostFailedCallbackIfError() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getLatLongForecast(lat: "37.33", lon: "-122.03") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetLatLongShouldPostFailedCallbackIfNoData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getLatLongForecast(lat: "37.33", lon: "-122.03") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetLatLongShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.latLongForecastCorrectData, response: FakeResponseData.responsKO, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getLatLongForecast(lat: "37.33", lon: "-122.03") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetLatLongShouldPostFailedCallbackIfIncorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.APIsRulerIncorrectData, response: FakeResponseData.responsOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getLatLongForecast(lat: "37.33", lon: "-122.03") { (success, WeatherResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(WeatherResult?.city)
      XCTAssertNil(WeatherResult?.temperature)
      XCTAssertNil(WeatherResult?.weatherCondition)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetLatLongShouldPostSuccessCallbackAndCorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.latLongForecastCorrectData, response: FakeResponseData.responsOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getLatLongForecast(lat: "37.33", lon: "-122.03") { (success, WeatherResult) in
      // Then
      let city = "Cupertino"
      let temperature = 9.1
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
