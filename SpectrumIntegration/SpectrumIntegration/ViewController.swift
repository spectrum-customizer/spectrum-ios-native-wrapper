//
//  ViewController.swift
//  SpectrumIntegration
//
//  Created by Tom Falkner on 8/20/19.
//  Copyright © 2019 Pollinate. All rights reserved.
//

import UIKit
import SpectrumCustomizer

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    WebCacheCleaner.clean()
    
    // Do any additional setup after loading the view.
    //let bounds : CGRect = self.view.bounds
    let bounds : CGRect = CGRect(x: 20, y: 100, width: self.view.bounds.width - 20, height: self.view.bounds.height - 200)
    let spectrum = SpectrumCustomizerView(frame: bounds)
    
    let customizerUrl = URL(string: "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/index.html")
    let request = URLRequest(url: customizerUrl!)
    
    spectrum.loadCustomizer(customizerUrl: request)
    self.view.addSubview(spectrum)
    self.view.sendSubviewToBack(spectrum)
  }
}
