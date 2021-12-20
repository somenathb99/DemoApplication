//
//  CarTest.swift
//  DemoAppTests
//
//  Created by Somenath Banerjee on 11/12/21.
//

import XCTest
@testable import DemoApp

class CarManufacturerCellTest: XCTestCase {
    
    var cell: CarManufacturerCell!

    override func setUp() {
        cell = CarManufacturerCell.init(style: .default, reuseIdentifier: CarManufacturerCell.identifier)
    }
    
    func testGetEvenCellColorForEvenIndexPath(){
        let color = cell.getColorForIndexPath(indexPath: IndexPath(row: 2, section: 0))
        XCTAssertTrue(color == UIColor(named: ColorPalate.manufacturerListEvenRow.rawValue))
        
    }
    
    func testShouldNotGetOddCellColorForEvenIndexPath(){
        let color = cell.getColorForIndexPath(indexPath: IndexPath(row: 3, section: 0))
        XCTAssertFalse(color == UIColor(named: ColorPalate.manufacturerListEvenRow.rawValue))
        
    }
    
    func testGetOddCellColorForOddIndexPath(){
        let color = cell.getColorForIndexPath(indexPath: IndexPath(row: 3, section: 0))
        XCTAssertTrue(color == UIColor(named: ColorPalate.manufacturerListOddRow.rawValue))
    }
    
    func testShouldNotGetEvenCellColorForOddIndexPath(){
        let color = cell.getColorForIndexPath(indexPath: IndexPath(row: 3, section: 0))
        XCTAssertFalse(color == UIColor(named: ColorPalate.manufacturerListEvenRow.rawValue))
        
    }
    
    
    override class func tearDown() {
        super.tearDown()
    }
}
