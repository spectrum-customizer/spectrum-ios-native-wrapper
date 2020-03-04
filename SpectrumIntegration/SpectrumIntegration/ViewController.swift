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

  let customizerUrl = "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/app.js"
  let product1 = "example-pro-product-1"
  let product2 = "example-pro-product-2"
  let recipeId = "BDTFLYW6"

  @IBOutlet weak var readableId: UITextField!
  @IBOutlet weak var spectrum: SpectrumCustomizerView!
  @IBAction func loadRecipe(_ sender: Any) {
    spectrum.loadRecipe(recipeId: recipeId, customizerUrl: customizerUrl)
  }

  @IBAction func loadFirstSku(_ sender: Any) {
    spectrum.loadSku(sku: product1, customizerUrl: customizerUrl)
  }

  @IBAction func loadSkuTwo(_ sender: Any) {
    spectrum.loadSku(sku: product2, customizerUrl: customizerUrl)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    spectrum.delegate = self
    spectrum.loadSku(sku: product1, customizerUrl: customizerUrl)
  }

  func addToCart(sender: SpectrumCustomizerView, skus: [String], recipeSetId: String, options: [String : String]) {
     print("In View Controller")
     print(skus)
     print(recipeSetId)
     print(options)
     if let angle = options["north"] {
       print(angle)
     }
   }

   func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [String: SpectrumPrice] {
    let prices = [ "sku1": SpectrumPrice(price: "$" + String(Int.random(in: 50 ... 100)) + ".00", inStock: true)]
    return prices
   }
}
