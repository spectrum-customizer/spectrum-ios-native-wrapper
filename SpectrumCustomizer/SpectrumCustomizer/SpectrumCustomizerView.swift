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
  @IBOutlet weak var webView: WKWebView!
  
  let nibName = "SpectrumCustomizerView"
  var contentView: UIView!
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpView()
  }
  
  public func loadCustomizer(customizerUrl: URLRequest) {
    webView.load(customizerUrl)
  }
  
  private func setUpView() {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: self.nibName, bundle: bundle)
    self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
    
    addSubview(contentView)
    
    let testUrl = URL(string:"https://google.com")
    let request = URLRequest(url: testUrl!)
    webView.frame = self.bounds
    webView.load(request)
    
    contentView.center = self.center
    
   
  }
}
