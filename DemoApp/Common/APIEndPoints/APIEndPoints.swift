//
//  APIEndPoints.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/12/21.
//

import Foundation

struct APIUrlString{
    func getEndPointForURL(service: APIEndPoints) -> String{
        return NetworkConstants.baseUrl + service.rawValue
    }
}

enum APIEndPoints: String {
    case manufacturer = "/v1/car-types/manufacturer?"
}
