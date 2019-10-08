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
  
  @IBOutlet weak var readableId: UITextField!
  @IBOutlet weak var spectrum: SpectrumCustomizerView!
  @IBAction func loadRecipe(_ sender: Any) {
    
    let arg = SpectrumArguments(fromRecipeId: "P2LD9U6W")
    spectrum.loadRecipe(args: arg)
  }
  
  @IBAction func loadFirstSku(_ sender: Any) {
    let product = "tmx-pro-guess-originals"
    let arg = SpectrumArguments(fromSku: product)
    spectrum.loadSku(args: arg)
  }
  
  @IBAction func loadSkuTwo(_ sender: Any) {
    let product = "tmx-pro-wilshire-38mm"
    let arg = SpectrumArguments(fromSku: product)
    spectrum.loadSku(args: arg)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //WebCacheCleaner.
    spectrum.loadCustomizer(customizerUrl: "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/app.js")
    
  }
}
