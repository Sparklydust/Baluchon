//
//  BaluchonUITests.swift
//  BaluchonUITests
//
//  Created by Roland Lariotte on 23/02/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest

class BaluchonUITests: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  func testMainVCsActions() {
    app.textFields["enter an amount "].tap()
    let changecurrencyButton = app.buttons["ChangeCurrency"]
    changecurrencyButton.tap()
    app.buttons["Convert"].tap()
    app.alerts["Error"].buttons["OK"].tap()
    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    element.swipeLeft()
    element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .textView).element.tap()
    changecurrencyButton.tap()
    app.buttons["Translate"].tap()
    element.swipeLeft()
    let tabBarsQuery = app.tabBars
    tabBarsQuery.buttons["Translator"].tap()
    tabBarsQuery.buttons["Exchange"].tap()
    tabBarsQuery.buttons["Forecast"].tap()
  }
}
