//
//  SpectrumUploadResponse.swift
//  SpectrumCustomizer
//
//  Created by Tom Falkner on 5/18/20.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

public struct SpectrumUploadAssetModel: Codable {
  public var uri : String
  public var id: Int

  init(id: Int, uri: String) {
    self.id = id
    self.uri = uri
  }

  init(dict:  Dictionary<String,AnyObject>) {
    self.id = dict["id"] as! Int
    self.uri = dict["uri"] as! String
  }
}
