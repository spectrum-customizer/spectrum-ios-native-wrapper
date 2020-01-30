//
//  SpectrumCustomizerViewTests.swift
//  SpectrumCustomizerTests
//
//  Created by Spectrum on 8/26/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import XCTest
@testable import SpectrumCustomizer

class SpectrumCustomizerViewTests: XCTestCase {
  
  var sut: SpectrumCustomizerView!
  
  override func setUp() {
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    sut = SpectrumCustomizerView(frame: frame)
  }
  
   func test_SpectrumCustomizerViewContainsAWebView() {
    XCTAssertFalse(sut.subviews.isEmpty, "SpectrumView should add a webview when instantiated")
  }
  
  func test_WebviewIsInstantiated() {
    XCTAssertNotNil(sut.webView)
  }
}
