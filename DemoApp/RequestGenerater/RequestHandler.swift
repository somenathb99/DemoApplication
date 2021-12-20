//
//  RequestHandler.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/12/21.
//

import Foundation

struct RequestHandler {
    
    private var baseURL: URL = {
        return URL(string: NetworkConstants.baseUrl)!
    }()
    
    /*
    Takes genric struct conformed by Request protocol as a parameter and call HttpUtility to get the response of the urlrequest and send back the response to respective view models
     */
    func requestList<T: Request>(with request: T, page: Int, completionHandler: @escaping(ResponseModel?, Error?) -> ()){
        
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        HttpUtility().httpGetRequest(urlRequest: encodedURLRequest, resultType: ResponseModel.self) { (result) in
            switch result {
            case .success(let manufacturer):
                completionHandler(manufacturer, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
