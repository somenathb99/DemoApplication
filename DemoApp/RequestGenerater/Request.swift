//
//  Request.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 11/12/21.
//

import Foundation

protocol Request {
    var path: String { get }
    var parameters: [String: String] {get}
}
