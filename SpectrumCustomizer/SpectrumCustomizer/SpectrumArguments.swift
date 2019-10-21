//
//  SpectrumArgument.swift
//  SpectrumCustomizer
//
//  Created by Spectrum on 8/26/19.
//  Copyright © 2019 Spectrum. All rights reserved.
//

import Foundation

public struct SpectrumArguments: Codable {
  public var containerSelector: String
  public var recipeSetReadableId: String?
  public var productId: String = ""
  
  public init(fromRecipeId recipeId: String) {
    recipeSetReadableId = recipeId
    containerSelector = ""
  }
  
  public init(fromSku sku: String) {
    productId = sku
    recipeSetReadableId = ""
    containerSelector = ""
  }
}
