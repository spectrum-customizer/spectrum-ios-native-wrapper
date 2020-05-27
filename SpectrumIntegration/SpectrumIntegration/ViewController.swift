//
//  ViewController.swift
//  SpectrumIntegration
//
//  Created by Spectrum on 8/20/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import UIKit
import SpectrumCustomizer

class ViewController: UIViewController, SpectrumCustomizerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  let customizerUrl = "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/app.js"
  let product1 = "example-pro-product-1"

  let product1 = "219815"
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
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
      imagePicker.allowsEditing = true
      imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
    }
  }


  internal func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[.originalImage] as? UIImage {
      spectrum.loadImage(image: pickedImage)
    } else {
      spectrum.cancelImageUpload()
    }
    picker.dismiss(animated: true, completion: nil)
  }

  internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    spectrum.cancelImageUpload()
    picker.dismiss(animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    spectrum.delegate = self
    spectrum.loadRecipe(recipeId: recipeId, customizerUrl: customizerUrl, sku: product1)
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

   func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [SpectrumPrice] {
    return skus.map({ (sku) -> SpectrumPrice in
      SpectrumPrice(sku: sku, price: "$99.00", inStock: true)
    })
   }

  func getImage(sender: SpectrumCustomizerView) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
      imagePicker.allowsEditing = true
      imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
    }
  }
}
