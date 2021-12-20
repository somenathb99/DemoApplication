//
//  ManufacturerModel.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 11/12/2021.
//

import Foundation

struct ResponseModel: Decodable {
    var page: Int?
    var pageSize: Int?
    var totalPageCount: Int?
    var wkda: [String: String]?
}


