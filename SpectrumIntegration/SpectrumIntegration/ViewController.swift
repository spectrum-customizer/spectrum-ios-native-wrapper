//
//  ViewController.swift
//  SpectrumIntegration
//
//  Created by Spectrum on 8/20/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import UIKit
import SpectrumCustomizer

class ViewController: UIViewController, SpectrumCustomizerViewDelegate {
  
  @IBOutlet weak var readableId: UITextField!
  @IBOutlet weak var spectrum: SpectrumCustomizerView!
  @IBAction func loadRecipe(_ sender: Any) {
    
    let arg = SpectrumArguments(fromRecipeId: "P2LD" + String(Int.random(in: 10 ... 99)) + "W")
    spectrum.loadRecipe(args: arg)
  }
  
  @IBAction func loadFirstSku(_ sender: Any) {
    let product = "example-pro-product-1"
    let arg = SpectrumArguments(fromSku: product)
    spectrum.loadSku(args: arg)
  }
  
  @IBAction func loadSkuTwo(_ sender: Any) {
    let product = "example-pro-product-2"
    let arg = SpectrumArguments(fromSku: product)
    spectrum.loadSku(args: arg)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    spectrum.delegate = self
    spectrum.loadCustomizer(customizerUrl: "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/app.js")
  }
  
  func addToCart(sender: SpectrumCustomizerView, skus: [String], recipeSetId: String, options: [String : String]) {
     print("In View Controller")
     print(skus)
     print(recipeSetId)
     print(options)
   }
   
   func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [String: SpectrumPrice] {
    let prices = [ "sku1": SpectrumPrice(price: "$" + String(Int.random(in: 50 ... 100)) + ".00", inStock: true)]
    return prices
   }
}
