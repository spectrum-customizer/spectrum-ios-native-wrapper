//
//  SpectrumArgument.swift
//  SpectrumCustomizer
//
//  Created by Tom Falkner on 8/26/19.
//  Copyright © 2019 Pollinate. All rights reserved.
//

import Foundation

public struct SpectrumArguments: Codable {
  public var containerSelector: String
  public var recipeSetReadableId: String?
  public var productId: String = ""
}
