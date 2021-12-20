//
//  DemoAppTests.swift
//  DemoAppTests
//
//  Created by Somenath Banerjee on 09/10/21.
//

import XCTest
@testable import DemoApp

class CarViewModelTests: XCTestCase {

    var carVm: CarViewModel!
    let carVC: CarViewController = CarViewController.instantiateFromStoryboard()
    var carRequest: CarModelRequest!
    
    override func setUp(){
        super.setUp()
        carRequest = CarModelRequest.create(with: "020")
        let manufacturer = Manufacturer(manufacturerName: "Abarth", manufacturerIdValue: "020")
        carVm = CarViewModel(request: carRequest, manufacturer: manufacturer, delegate: carVC)
        
        carVm.cars = [Car(carModelName: "Audi"), Car(carModelName: "BMW")]
    }
    
    func testCarModelRequest(){
        XCTAssertTrue(carRequest.path == "v1/car-types/main-types")
        XCTAssertTrue(carRequest.parameters["manufacturer"] == "020")
    }
    
    func testFetchCarsValidRequestSholdReturnValidResponse(){

        let expectency = expectation(description: "ValidRequestSholdReturnValidResponse")
                
        RequestHandler().requestList(with: carRequest, page: 0) { car, error in
            XCTAssertNil(error)
            XCTAssertTrue(car?.page ?? 1 == 0)
            XCTAssertTrue(car?.wkda?.count ?? 0 == 11)
            expectency.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCheckIFReachedToLastPage(){
        let status = carVm.checkIFReachedToLastPage(current: 0, total: 0)
        XCTAssertTrue(status)
    }
    
    func testCheckIFNotReachedToLastPage(){
        let status = carVm.checkIFReachedToLastPage(current: 0, total: 2)
        XCTAssertFalse(status)
    }
    
    func testGetListFromWKDAObject(){
        let wkda = ["Audi": "Audi", "BMW": "BMW"]
        let car = carVm.getList(wk: wkda)
        XCTAssertTrue(car.count == 2)
        XCTAssertTrue(car[0].carModel == "Audi")
    }
    
    func testGetCarIndex(){
        let index = carVm.car(at: 0)
        XCTAssertTrue(index.carModel == "Audi")
    }
    
    func testWrongCarIndexShouldNotGetCar(){
        let index = carVm.car(at: 1)
        XCTAssertFalse(index.carModel == "Audi")
    }
    
    func testGetTitleForCarandManufacturer(){
        let title = carVm.getAlertTitle(at: 0)
        XCTAssertTrue(title == "<Abarth>, <Audi>")
    }
    
    func testCalCulateIndePathsToReload(){
        let car = [Car(carModelName: "Audi"), Car(carModelName: "BMW")]
        let indexPaths = carVm.calculateIndexPathsToReload(from: car)
        XCTAssertTrue(indexPaths.count == 2)
    }
    
    func testCalCulateIndePathsToReloadFalse(){
        let car = [Car(carModelName: "Audi"), Car(carModelName: "BMW")]
        let indexPaths = carVm.calculateIndexPathsToReload(from: car)
        XCTAssertFalse(indexPaths.count == 3)
    }
    
    func testCurrentCarCount(){
        XCTAssertTrue(carVm.currentCount == 2)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}
