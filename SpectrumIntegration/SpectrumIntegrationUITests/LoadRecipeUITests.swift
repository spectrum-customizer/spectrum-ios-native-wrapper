//
//  LoadRecipeUITests.swift
//  SpectrumIntegrationUITests
//
//  Created by Spectrum on 8/28/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import XCTest

class LoadRecipeUITests: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app.launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_ItShouldHaveAButtonToLoadARecipe() {
    XCTAssert(app.buttons["Load Recipe"].exists)
  }
  
  func test_ItShouldHaveATextFieldToEnterAProduct() {
    XCTAssert(app.textFields["RecipeSet Id"].exists)
  }
  
  
  
}
