//
//  SpectrumImage.swift
//  SpectrumCustomizer
//
//  Created by Tom Falkner on 5/18/20.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

public struct SpectrumImage: Codable {
  public var uploadUri: String
  public var response: [SpectrumUploadAssetModel]
  public var featureHandle: String
  public var categoryHandle: String
  public var productHandle: String
  public var storageKey: String
  public var width: Int
  public var height: Int

  public init() {
    self.uploadUri = ""
    self.response = []
    self.storageKey = ""
    self.width = 0
    self.height = 0
    self.productHandle = ""
    self.featureHandle = ""
    self.categoryHandle = ""
  }

  public init(uploadUri: String, width: Int, height: Int, featureHandle: String, productHandle: String, storageKey: String, categoryHandle: String, response: [SpectrumUploadAssetModel]) {
    self.uploadUri = uploadUri
    self.width = width
    self.height = height
    self.categoryHandle = categoryHandle
    self.featureHandle = featureHandle
    self.productHandle = productHandle
    self.storageKey = storageKey
    self.response = response
  }

  public init(dict: Dictionary<String,AnyObject>) {
    let uploadUri = dict["uploadUri"] as! String
    let width = dict["width"] as! Int
    let height = dict["height"] as! Int
    let featureHandle = dict["featureHandle"] as! String
    let productHandle = dict["productHandle"] as! String
    let categoryHandle = dict["categoryHandle"] as! String
    let storageKey = dict["storageKey"] as! String
    let response = dict["response"] as! [SpectrumUploadAssetModel]
    self.init(uploadUri: uploadUri, width: width, height: height, featureHandle: featureHandle, productHandle: productHandle, storageKey: storageKey, categoryHandle: categoryHandle, response: response);
  }
}
