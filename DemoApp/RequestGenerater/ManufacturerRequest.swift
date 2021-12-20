//
//  ManufacturerRequest.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/10/21.
//

import Foundation


// MARK: Create Manufacturer request with parameters
struct ManufacturerRequest: Request{
    
    var path: String {
      return "v1/car-types/manufacturer"
    }
    
    var parameters: [String: String]
    private init(parameters: [String: String]) {
      self.parameters = parameters
    }
}

// MARK: Create Manufacturer parameter with default values
extension ManufacturerRequest {
  static func create() -> ManufacturerRequest {
    let defaultParameters = ["pageSize": "15", "wa_key": "coding-puzzle-client-449cc9d"]
    return ManufacturerRequest(parameters: defaultParameters)
  }
}
