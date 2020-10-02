//
//  GetTranslatorTestCase.swift
//  BaluchonTests
//
//  Created by Roland Lariotte on 18/03/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Baluchon
import XCTest

class GetTranslationTestCase: XCTestCase {
  func testGetTranslationShouldPostFailedCallbackIfError() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getTranslation(q: "marcher ou mourir", source: "fr", target: "en") { (success, translationResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(translationResult)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.001)
  }
  
  func testGetTranslationShouldPostFailedCallbackIfNoData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getTranslation(q: "marcher ou mourir", source: "fr", target: "en") { (success, translationResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(translationResult)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.001)
  }
  
  func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getTranslation(q: "marcher ou mourir", source: "fr", target: "en") { (success, translationResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(translationResult)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.001)
  }
  
  func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.APIsRulerIncorrectData, response: FakeResponseData.responseOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getTranslation(q: "marcher ou mourir", source: "fr", target: "en") { (success, translationResult) in
      // Then
      XCTAssertFalse(success)
      XCTAssertNil(translationResult)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.001)
  }
  
  func testGetTranslationShouldPostSuccessCallbackAndCorrectData() {
    // Given
    let apiSRuler = APIsRuler(session: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseOK, error: nil))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    apiSRuler.getTranslation(q: "Marcher ou mourir", source: "fr", target: "en") { (success, translationResult) in
      // Then
      let translatedText = "walk or die"
      
      XCTAssertTrue(success)
      XCTAssertNotNil(translationResult)
      XCTAssertEqual(translatedText, translationResult!)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.001)
  }
}
