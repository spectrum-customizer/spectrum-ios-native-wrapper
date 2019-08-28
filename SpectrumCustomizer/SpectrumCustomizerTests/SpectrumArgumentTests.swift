//
//  SpectrumArgumentTests.swift
//  SpectrumCustomizerTests
//
//  Created by Tom Falkner on 8/26/19.
//  Copyright © 2019 Pollinate. All rights reserved.
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
    let arg = SpectrumArguments(containerSelector: selector, recipeSetReadableId: readableId, productId: productId)
    XCTAssertNotNil(arg)
  }
  
  
  func test_ItShouldImplementCodable() {
    let arg = SpectrumArguments(containerSelector: selector, recipeSetReadableId: readableId, productId: productId)
    
    let jsonEncoder = JSONEncoder()
    
    do {
      let jsonData = try jsonEncoder.encode(arg)
      let jString = String(data: jsonData, encoding: .utf8)
      XCTAssertEqual(jString!, "{\"containerSelector\":\"#main\",\"recipeSetReadableId\":\"ABCD123\",\"productId\":\"test-sku\"}")
    } catch {
      XCTFail("Unable to serialize SpectrumArgument")
    }
  }
}
