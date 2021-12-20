//
//  ManufacturerRequest.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/10/21.
//

import Foundation

// MARK: Create Manufacturer request with parameters
struct CarModelRequest: Request{
    var path: String {
      return "v1/car-types/main-types"
    }
    
    var parameters: [String: String]
    private init(parameters: [String: String]) {
      self.parameters = parameters
    }
}

// MARK: Create car parameter with default values
extension CarModelRequest {
    static func create(with manufacturer: String) -> CarModelRequest {
        let defaultParameters = ["manufacturer": manufacturer, "pageSize": "15", "wa_key": "coding-puzzle-client-449cc9d"]
    return CarModelRequest(parameters: defaultParameters)
  }
}
