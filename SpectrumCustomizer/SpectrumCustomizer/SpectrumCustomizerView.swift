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

  //@IBOutlet weak var webView: WKWebView!
  //@IBOutlet weak var webView: WKWebView!
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var webView: WKWebView!
  
  let nibName = "SpectrumCustomizerView"
 // var contentView: UIView!
  
  
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
    
    //let nib = UINib(nibName: self.nibName, bundle: bundle)
    //self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
    //let nib = UINib(nibName: self.nibName, bundle: bundle)
    //nib.instantiate(withOwner: self, options: nil).first
    
    bundle.loadNibNamed("SpectrumCustomizerView", owner: self, options: nil)
    
    addSubview(contentView)
    contentView.frame = self.bounds
    self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    //webView.frame = self.bounds
    
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
      
      let serialized = "spectrum.loadRecipe('\(jString!)')"
      
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
      
      let serialized = "spectrum.loadSku('\(jString!)')"
      
      webView.evaluateJavaScript(serialized, completionHandler: {(html: AnyObject?, error: NSError?) in
        print(html!)
        } as? (Any?, Error?) -> Void)
      
    } catch {
      print("error loading recipe")
    }
  }
  
  
}
