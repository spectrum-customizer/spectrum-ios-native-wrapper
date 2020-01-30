//
//  SpectrumCustomizerView.swift
//  SpectrumCustomizer
//
//  Created by Spectrum on 8/19/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import UIKit
import WebKit

let addToCart = "addToCart"
let getPrice = "getPrice"

public protocol SpectrumCustomizerViewDelegate: class {
  func addToCart(sender: SpectrumCustomizerView, skus: [String], recipeSetId: String, options: [String: String])
  func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [String: SpectrumPrice]
}

public class SpectrumCustomizerView: UIView, WKNavigationDelegate, WKScriptMessageHandler {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var webView: WKWebView!

  weak public var delegate:SpectrumCustomizerViewDelegate?

  let nibName = "SpectrumCustomizerView"

  var customizerProduct = ""
  var customizerRecipe = ""
  var customizerSource = ""
  var webViewReady = false
  var webSourceLoaded = false

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpView()
  }

  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    webViewReady = true
    if !webSourceLoaded && customizerSource != "" {
      load()
      webSourceLoaded = true
    }
  }

  private func setUpView() {
    let bundle = Bundle(for: SpectrumCustomizerView.self)

    bundle.loadNibNamed("SpectrumCustomizerView", owner: self, options: nil)

    addSubview(contentView)
    contentView.frame = self.bounds
    self.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    webView.navigationDelegate = self;
    webView.configuration.userContentController.add(self, name: addToCart)
    webView.configuration.userContentController.add(self, name: getPrice)
    guard let url = bundle.url(forResource: "index", withExtension: "html", subdirectory: nil) else { return }
    webView.loadFileURL(url, allowingReadAccessTo: url)
  }

  public func loadRecipe(recipeId: String, customizerUrl: String) {

    customizerSource = customizerUrl;
    customizerProduct = "";
    customizerRecipe = recipeId;

    if webViewReady {
      webSourceLoaded = false
      webViewReady = false
      webView.reload()
    }
  }

  func load() {
    var script = ""

    if customizerProduct != "" {
      script = "window.history.replaceState({}, 'new product', '?'); window.spectrumLoadProduct='\(customizerProduct)'; loadCustomizer('\(customizerSource)')"
    }
    else if customizerRecipe != "" {
      script = "window.history.replaceState({}, 'new recipe', '?recipeId=\(customizerRecipe)'); loadCustomizer('\(customizerSource)')"
    }

       webView.evaluateJavaScript(script, completionHandler: {(html: AnyObject?, error: NSError?) in
           print(html!)
       } as? (Any?, Error?) -> Void)
  }
  /**
   */
  public func loadSku(sku: String, customizerUrl: String) {

    customizerSource = customizerUrl;
    customizerProduct = sku;
    customizerRecipe = ""

    if webViewReady {
      webSourceLoaded = false
      webViewReady = false
      webView.reload()
    }
  }

  public func userContentController(_ userContentController: WKUserContentController,
                             didReceive message: WKScriptMessage) {
    if message.name == addToCart {
      guard let dict = message.body as? [String: AnyObject],
        let recipeSetId = dict["recipeSetId"] as? String,
        let skus = dict["skus"] as? [String],
        let options = dict["options"] as? [String: String] else {
          return
      }

      delegate?.addToCart(sender: self, skus: skus, recipeSetId: recipeSetId, options: options)

    } else if message.name == getPrice {

      guard let dict = message.body as? [String: AnyObject],
        let callbackId = dict["callbackId"] as? Int,
        let skus = dict["skus"] as? [String],
        let options = dict["options"] as? [String: String] else {
          return
      }

      let prices = delegate?.getPrice(sender: self, skus: skus, options: options)


      let jsonEncoder = JSONEncoder()
      if let unWrappedPrices = prices,
        let pricesJson = try? jsonEncoder.encode(unWrappedPrices),
        let pricesText = String(data: pricesJson, encoding: String.Encoding.utf8) {

        let script = "resolvePrice(" + String(callbackId) + ", " + pricesText + ");"
        webView.evaluateJavaScript(script, completionHandler: {(html: AnyObject?, error: NSError?) in
        print(html!)
        } as? (Any?, Error?) -> Void)
      }
     }
   }
 }
