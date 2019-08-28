//
//  SpectrumCustomizerViewTests.swift
//  SpectrumCustomizerTests
//
//  Created by Tom Falkner on 8/26/19.
//  Copyright © 2019 Pollinate. All rights reserved.
//

import XCTest
@testable import SpectrumCustomizer

class SpectrumCustomizerViewTests: XCTestCase {
  
  var sut: SpectrumCustomizerView!
  
  override func setUp() {
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    sut = SpectrumCustomizerView(frame: frame)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  
  func test_SpectrumCustomizerViewContainsAWebView() {
    XCTAssertFalse(sut.subviews.isEmpty, "SpectrumView should add a webview when instantiated")
  }
  
  func test_WebviewIsInstantiated() {
    XCTAssertNotNil(sut.webView)
  }
  
  func test_LoadsCustomUrl() {
    let blobStorageUri = "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/index.html"
    let customizerUrl = URL(string: blobStorageUri)
    let request = URLRequest(url: customizerUrl!)
    sut.loadCustomizer(customizerUrl: request)
    
    if let loadedUrl = sut.webView.url {
      XCTAssertEqual(loadedUrl.absoluteString, blobStorageUri)
    } else {
      XCTFail("Url no loaded")
    }
  }
  
  func test_loadingARecipe() {
    let args = SpectrumArguments(containerSelector: "#main", recipeSetReadableId: "ABCD1245", productId: "123456")
  }
}
