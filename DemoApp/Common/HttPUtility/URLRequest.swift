//
//  URLRequest.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/10/21.
//

import Foundation

extension URLRequest {
    func encode(with parameters: [String: String]?) -> URLRequest {
        guard let parameters = parameters else {
            return self
        }
        
        var encodedURLRequest = self
        
        if let url = self.url,
           let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            var newUrlComponents = urlComponents
            let queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            newUrlComponents.queryItems = queryItems
            encodedURLRequest.url = newUrlComponents.url
            encodedURLRequest.timeoutInterval = 10
            return encodedURLRequest
        } else {
            return self
        }
    }
}
