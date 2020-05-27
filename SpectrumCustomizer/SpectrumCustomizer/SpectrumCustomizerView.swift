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
let getImage = "getImage"
let getPendingImage = "getPendingImage"

public protocol SpectrumCustomizerViewDelegate: class {
  func addToCart(sender: SpectrumCustomizerView, skus: [String], recipeSetId: String, options: [String: String])
  func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [SpectrumPrice]
  func getImage(sender: SpectrumCustomizerView)
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
  var uploadOptions : SpectrumImage
  var uploading = false

  public override init(frame: CGRect) {
    self.uploadOptions = SpectrumImage()
    super.init(frame: frame)
    setUpView()
  }

  public required init?(coder aDecoder: NSCoder) {
    self.uploadOptions = SpectrumImage()
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
    webView.configuration.userContentController.add(self, name: getImage)
    webView.configuration.userContentController.add(self, name: getPendingImage)
    guard let url = bundle.url(forResource: "index", withExtension: "html", subdirectory: nil) else { return }
    webView.loadFileURL(url, allowingReadAccessTo: url)
  }

  public func loadRecipe(recipeId: String, customizerUrl: String, sku: String = "") {

    customizerSource = customizerUrl;
    customizerProduct = sku;
    customizerRecipe = recipeId;

    if webViewReady {
      webSourceLoaded = false
      webViewReady = false
      webView.reload()
    }
  }

  func load() {
    var script = ""

    if customizerRecipe != "" {
      script = "window.history.replaceState({}, 'new recipe', '?recipeId=\(customizerRecipe)'); window.spectrumLoadProduct='\(customizerProduct)'; loadCustomizer('\(customizerSource)')"
    } else if customizerProduct != "" {
      script = "window.history.replaceState({}, 'new product', '?'); window.spectrumLoadProduct='\(customizerProduct)'; loadCustomizer('\(customizerSource)')"
    }
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

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

  public func uploadImageToSpectrum(url: URL, image : UIImage) {

    let boundary = "Boundary-\(UUID().uuidString)"
    let session = URLSession.shared
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

    var data = Data()
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"file\"; filename=\"test.png\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
    data.append(image.pngData()!)
    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

    session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in if error == nil {

      let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)

      if let json = jsonData as? [[String: AnyObject]] {
        self.uploadOptions.response = json.map{SpectrumUploadAssetModel(dict: $0)}
      }
      else {
        self.cancelImageUpload()
      }
      self.sendImagesToSpectrum()
    }
    }).resume()
  }

  public func sendImagesToSpectrum() {

    let jsonEncoder = JSONEncoder()

    if let artworkJson = try? jsonEncoder.encode(self.uploadOptions),
       let artworkText = String(data: artworkJson, encoding: String.Encoding.utf8) {
        let script = "resolveArtwork(\(artworkText));"
          DispatchQueue.main.async(execute: {
            self.webView.evaluateJavaScript(script, completionHandler: nil)
          })
    }
  }

  public func reloadWebView() {
    webSourceLoaded = false
    webViewReady = false
    DispatchQueue.main.async(execute: {
      self.webView.reload()
    })
  }

  public func loadImage(image: UIImage) {
    uploadOptions.width = Int(image.size.width)
    uploadOptions.height = Int(image.size.height)
    let url = URL(string: uploadOptions.uploadUri)!
    uploadImageToSpectrum(url: url, image: image)
  }

  public func cancelImageUpload() {
    uploading = false
    webView.evaluateJavaScript("spectrumCancelImageUpload();", completionHandler: nil)
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
        webView.evaluateJavaScript(script, completionHandler: nil)
      }
     } else if message.name == getImage {

       guard let img = message.body as? [String: AnyObject] else {
         return;
        }

       uploading = true
       uploadOptions = SpectrumImage(dict: img)
       delegate?.getImage(sender: self)

    } else if message.name == getPendingImage {
      if (uploading) {
        self.sendImagesToSpectrum()
        uploading = false
      } else {
        webView.evaluateJavaScript("resolveArtwork();", completionHandler: nil)
     }
    }
   }
 }
