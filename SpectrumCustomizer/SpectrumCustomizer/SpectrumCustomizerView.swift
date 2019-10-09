//
//  SpectrumCustomizerView.swift
//  SpectrumCustomizer
//
//  Created by Tom Falkner on 8/19/19.
//  Copyright © 2019 Pollinate. All rights reserved.
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
    if !webSourceLoaded && customizerSource != "" {
      load(customizerUrl: customizerSource)
      webSourceLoaded = true
    }
  }
  
  private func setUpView() {
    guard let bundle = Bundle(identifier: "com.pollinate.SpectrumCustomizer") else { return }
    
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
 
  
  
  public func loadCustomizer(customizerUrl: String) {
    if webViewReady {
      load(customizerUrl: customizerUrl)
      webSourceLoaded = true
    } else {
      customizerSource = customizerUrl
    }
  }
  
  public func loadRecipe(args: SpectrumArguments) {
    
    let jsonEncoder = JSONEncoder();
    
    do {
      let jsonData = try jsonEncoder.encode(args)
      let jString = String(data: jsonData, encoding: .utf8)
      
      let serialized = "integration.loadRecipe('\(jString!)')"
      
      webView.evaluateJavaScript(serialized, completionHandler: {(html: AnyObject?, error: NSError?) in
        print(html!)
        } as? (Any?, Error?) -> Void)
      
    } catch {
      print("error loading recipe")
    }
  }
  
  func load(customizerUrl: String) {
    let script = "loadCustomizer('" + customizerUrl + "')"
       webView.evaluateJavaScript(script, completionHandler: {(html: AnyObject?, error: NSError?) in
           print(html!)
       } as? (Any?, Error?) -> Void)
  }
  /**
   */
  public func loadSku(args: SpectrumArguments) {
    
    let jsonEncoder = JSONEncoder();
    
    do {
      let jsonData = try jsonEncoder.encode(args)
      let jString = String(data: jsonData, encoding: .utf8)
      
      let serialized = "integration.loadSku('\(jString!)')"
      
      webView.evaluateJavaScript(serialized, completionHandler: {(html: AnyObject?, error: NSError?) in
        print(html!)
        } as? (Any?, Error?) -> Void)
      
    } catch {
      print("error loading recipe")
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
