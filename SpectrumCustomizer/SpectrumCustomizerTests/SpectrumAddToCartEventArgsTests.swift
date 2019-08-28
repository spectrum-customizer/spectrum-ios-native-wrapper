//
//  SpectrumAddToCartEventArgs.swift
//  SpectrumCustomizerTests
//
//  Created by Tom Falkner on 8/27/19.
//  Copyright © 2019 Pollinate. All rights reserved.
//

import XCTest
@testable import SpectrumCustomizer

class SpectrumAddToCartEventArgsTests: XCTestCase {

  let recipe = "ABCD1234"
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_shouldHaveRecipeSetReadableId() {
    let args = SpectrumAddToCartEventArgs(recipeSetReadableId: recipe)
    XCTAssertEqual(recipe, args.recipeSetReadableId)
  }
  
  func test_shouldImplementCodable() {
    
    let args = SpectrumAddToCartEventArgs(recipeSetReadableId: recipe)
    let jsonEncoder = JSONEncoder()
    
    do {
      let jsonData = try jsonEncoder.encode(args)
      let jString = String(data: jsonData, encoding: .utf8)
      XCTAssertEqual(jString!, "{\"recipeSetReadableId\":\"ABCD1234\"}")
      
    } catch {
      XCTFail("SpectrumAddToCartEventArgs not codable")
    }
    
  }
}

