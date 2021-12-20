//
//  HttpUtility.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/12/21.
//

import Foundation
import UIKit

struct HttpUtility{
    
    /*
     The method which is responsible for making the url request calls with the help of URLSession and convert the data into models and return the model back in Result success to the struct which actually made the request, resultType is the type of the model in generic.
     */
    func httpGetRequest<T: Decodable>(urlRequest: URLRequest, resultType: T.Type, completionHandler: @escaping(Result<T,Error>) -> ()) {
        
        URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if let err = error {
                completionHandler(.failure(err))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                if let error = error{
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                if let error = error{
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let result = try decoder.decode(T.self, from: data)
                print("json: \(json)")
                completionHandler(.success(result))
            } catch let error {
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }.resume()
        
       
    }
}
