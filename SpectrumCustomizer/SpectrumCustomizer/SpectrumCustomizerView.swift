//
//  SpectrumCustomizerView.swift
//  SpectrumCustomizer
//
//  Created by Tom Falkner on 8/19/19.
//  Copyright © 2019 Pollinate. All rights reserved.
//

import UIKit
import WebKit

public class SpectrumCustomizerView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var webView: WKWebView!
  
  let nibName = "SpectrumCustomizerView"
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpView()
  }
  
  private func setUpView() {
    guard let bundle = Bundle(identifier: "com.pollinate.SpectrumCustomizer") else { return }
    
    bundle.loadNibNamed("SpectrumCustomizerView", owner: self, options: nil)
    
    addSubview(contentView)
    contentView.frame = self.bounds
    self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    guard let url = bundle.url(forResource: "index", withExtension: "html", subdirectory: nil) else { return }
    
    webView.loadFileURL(url, allowingReadAccessTo: url)
    let request = URLRequest(url: url)
    webView.load(request)
    
  }
  
  public func loadCustomizer(customizerUrl: URLRequest) {
    //webView.load(customizerUrl)
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
  
  
}
