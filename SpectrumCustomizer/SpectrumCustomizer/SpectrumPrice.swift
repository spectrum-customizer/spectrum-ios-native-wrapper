//
//  SpectrumPrice.swift
//  SpectrumCustomizer
//
//  Created by Spectrum on 10/9/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import Foundation


public struct SpectrumPrice: Codable {
  public var sku: String
  public var price: Decimal
  public var inStock: Bool

  public init(sku: String, price: String, inStock: Bool) {

    let filteredPrice = price.replacingOccurrences(of: "[^0-9\\.]", with: "", options: .regularExpression)

    self.sku = sku
    self.price = Decimal(string: filteredPrice) ?? 0
    self.inStock = inStock
  }

  public init(sku: String, price: Decimal, inStock: Bool) {
    self.sku = sku
    self.price = price
    self.inStock = inStock
  }
}
