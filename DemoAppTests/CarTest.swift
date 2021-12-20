//
//  CarTest.swift
//  DemoAppTests
//
//  Created by Somenath Banerjee on 11/12/21.
//

import XCTest
@testable import DemoApp

class CarTest: XCTestCase {
    
    var car: Car!

    override func setUp() {
        car = Car(carModelName: "Audi")
    }
    
    func testCarModelName(){
        XCTAssertTrue(car.carModel == "Audi")
    }
    
    func testWrongCarModelName(){
        XCTAssertFalse(car.carModel == "BMW")
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}
