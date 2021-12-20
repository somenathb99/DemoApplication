//
//  CarTest.swift
//  DemoAppTests
//
//  Created by Somenath Banerjee on 11/12/21.
//

import XCTest
@testable import DemoApp

class MamufacturerTest: XCTestCase {
    
    var manufacturer: Manufacturer!

    override func setUp() {
        manufacturer = Manufacturer(manufacturerName: "Audi", manufacturerIdValue: "020")
    }
    
    
    func testManufacturerName(){
        XCTAssertTrue(manufacturer.manufacturer == "Audi")
    }
    
    func testWrongManufacturerName(){
        XCTAssertFalse(manufacturer.manufacturer == "BMW")
    }
    
    func testManufacturerId(){
        XCTAssertTrue(manufacturer.manufacturerId == "020")
    }
    
    func testWrongManufacturerId(){
        XCTAssertFalse(manufacturer.manufacturerId == "200")
    }
    
    

}
