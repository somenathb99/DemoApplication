//
//  ManufacturerViewModelTest.swift
//  DemoAppTests
//
//  Created by Somenath Banerjee on 11/12/21.
//

import XCTest
@testable import DemoApp

class ManufacturerViewModelTest: XCTestCase {
    
    var manufacturerVm: ManufacturerViewModel!
    let manufacturerVC: ManufacturerViewController = ManufacturerViewController.instantiateFromStoryboard()
    var manufacturerRequest: ManufacturerRequest!

    override func setUp()  {
        manufacturerRequest = ManufacturerRequest.create()
        manufacturerVm = ManufacturerViewModel(request: manufacturerRequest, delegate: manufacturerVC)
        
        manufacturerVm.manufacturers = [Manufacturer(manufacturerName: "Audi", manufacturerIdValue: "020"), Manufacturer(manufacturerName: "BMW", manufacturerIdValue: "100")]
    }

    func testManufacturerModelRequest(){
        XCTAssertTrue(manufacturerRequest.path == "v1/car-types/manufacturer")
    }
    
    func testFetchManufacturersValidRequestSholdReturnValidResponse(){

        let expectency = expectation(description: "ValidRequestSholdReturnValidResponse")
                
        RequestHandler().requestList(with: manufacturerRequest, page: 0) { car, error in
            XCTAssertNil(error)
            XCTAssertTrue(car?.page ?? 1 == 0)
            XCTAssertTrue(car?.wkda?.count ?? 0 == 15)
            expectency.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCheckIFReachedToLastPage(){
        let status = manufacturerVm.checkIFReachedToLastPage(current: 0, total: 0)
        XCTAssertTrue(status)
    }
    
    func testCheckIFNotReachedToLastPage(){
        let status = manufacturerVm.checkIFReachedToLastPage(current: 0, total: 2)
        XCTAssertFalse(status)
    }
    
    func testGetListFromWKDAObject(){
        let wkda = ["020": "Audi", "100": "BMW"]
        let car = manufacturerVm.getList(wk: wkda)
        XCTAssertTrue(car.count == 2)
        XCTAssertTrue(car[0].manufacturer == "Audi")
    }
    
    func testGetCarIndex(){
        let index = manufacturerVm.manufacturer(at: 0)
        XCTAssertTrue(index.manufacturer == "Audi")
    }
    
    func testWrongCarIndexShouldNotGetCar(){
        let index = manufacturerVm.manufacturer(at: 1)
        XCTAssertFalse(index.manufacturer == "Audi")
    }
    
    func testCalCulateIndePathsToReload(){
        let manufacturer = [Manufacturer(manufacturerName: "Audi", manufacturerIdValue: "020"), Manufacturer(manufacturerName: "BMW", manufacturerIdValue: "100")]
        let indexPaths = manufacturerVm.calculateIndexPathsToReload(from: manufacturer)
        XCTAssertTrue(indexPaths.count == 2)
    }
    
    func testCalCulateIndePathsToReloadFalse(){
        let manufacturer = [Manufacturer(manufacturerName: "Audi", manufacturerIdValue: "020"), Manufacturer(manufacturerName: "BMW", manufacturerIdValue: "100")]
        let indexPaths = manufacturerVm.calculateIndexPathsToReload(from: manufacturer)
        XCTAssertFalse(indexPaths.count == 3)
    }
    
    func testCurrentCarCount(){
        XCTAssertTrue(manufacturerVm.currentCount == 2)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}
