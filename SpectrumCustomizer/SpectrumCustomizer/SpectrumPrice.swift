//
//  SpectrumPrice.swift
//  SpectrumCustomizer
//
//  Created by Spectrum on 10/9/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import Foundation


public struct SpectrumPrice: Codable {
  public var price: String
  public var inStock: Bool
  
  public init(price: String, inStock: Bool) {
    self.price = price
    self.inStock = inStock
  }
}
