//
//  SpectrumArgumentTests.swift
//  SpectrumCustomizerTests
//
//  Created by Spectrum on 8/26/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import XCTest
@testable import SpectrumCustomizer

class SpectrumArgumentTests: XCTestCase {
  
  let readableId = "ABCD123"
  let selector = "#main"
  let productId = "test-sku"
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_Existence() {
    let arg = SpectrumArguments(fromRecipeId: readableId)
    XCTAssertNotNil(arg)
  }
  
  
  func test_ItShouldImplementCodable() {
    let arg = SpectrumArguments(fromRecipeId: readableId)
    
    let jsonEncoder = JSONEncoder()
    
    do {
      let jsonData = try jsonEncoder.encode(arg)
      let jString = String(data: jsonData, encoding: .utf8)
      XCTAssertEqual(jString!, "{\"containerSelector\":\"\",\"recipeSetReadableId\":\"ABCD123\",\"productId\":\"\"}")
    } catch {
      XCTFail("Unable to serialize SpectrumArgument")
    }
  }
}
