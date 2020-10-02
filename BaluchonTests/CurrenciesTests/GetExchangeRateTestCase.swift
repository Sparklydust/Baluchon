//
//  GetExchangeRateTestCase.swift
//  BaluchonTests
//
//  Created by Roland Lariotte on 18/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Baluchon
import XCTest

class GetExchangeRateTestCase: XCTestCase {
  func testGetExchangeRateShouldPostFailedCallbackIfError() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getExchangeRate(from: "EUR", to: "USD", amount: "1") { (success, ConversionResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(ConversionResult?.exchangeResult)
      XCTAssertNil(ConversionResult?.exchangeRate)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }

  func testGetExchangeRateShouldPostFailedCallbackIfNoData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getExchangeRate(from: "EUR", to: "USD", amount: "1") { (success, ConversionResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(ConversionResult?.exchangeResult)
      XCTAssertNil(ConversionResult?.exchangeRate)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }

  func testGetExchangeRateShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getExchangeRate(from: "EUR", to: "USD", amount: "1") { (success, ConversionResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(ConversionResult?.exchangeResult)
      XCTAssertNil(ConversionResult?.exchangeRate)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }

  func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.APIsRulerIncorrectData, response: FakeResponseData.responseOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getExchangeRate(from: "EUR", to: "USD", amount: "1") { (success, ConversionResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(ConversionResult?.exchangeResult)
      XCTAssertNil(ConversionResult?.exchangeRate)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetExchangeRateShouldPostSuccessCallbackAndCorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getExchangeRate(from: "EUR", to: "USD", amount: "1") { (success, ConversionResult) in
      // Then
      let rate = 1.135647
      let result = 1.135647
      
      XCTAssertTrue(success)
      XCTAssertNotNil(ConversionResult?.exchangeResult)
      XCTAssertNotNil(ConversionResult?.exchangeRate)
      XCTAssertEqual(rate, ConversionResult!.exchangeRate)
      XCTAssertEqual(result, ConversionResult!.exchangeResult)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}
