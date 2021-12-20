//
//  ManufacturerViewModel.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/12/21.
//

import Foundation

final class CarViewModel {
    
    weak var delegate: CarManufacturerViewModelDelegate?
    let request: CarModelRequest
    
    var currentCount: Int {
      return cars.count
    }
    
    func car(at index: Int) -> Car {
      return cars[index]
    }
    
    private var isFetchInProgress = false
    private var currentPage = 0
    private var totalPageCount: Int = 1
    
    var cars: [Car] = []
    
    var manufacturer: Manufacturer?
    
    func getAlertTitle(at index: Int) -> String {
        if let manufacturer = manufacturer {
            return "<\(manufacturer.manufacturer ?? "")>, <\(car(at: index).carModel ?? "")>"
        }
        return "<\(car(at: index).carModel ?? "")>"
    }
    
    init(request: CarModelRequest, manufacturer: Manufacturer?, delegate: CarManufacturerViewModelDelegate){
        self.request = request
        self.manufacturer = manufacturer
        self.delegate = delegate
    }
    
    func fetchCars() {
        guard !isFetchInProgress, currentPage < totalPageCount else {
            return
        }
        
        isFetchInProgress = true
        
        RequestHandler().requestList(with: request, page: currentPage) {[unowned self] car, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.totalPageCount = car?.totalPageCount ?? 0
                    self.cars.append(contentsOf: self.getList(wk: car?.wkda ?? [:]))
                    let isReachedToLast = self.checkIFReachedToLastPage(current: self.currentPage, total: self.totalPageCount)
                    if car?.page ?? 0 >= 1 {
                      let indexPathsToReload = self.calculateIndexPathsToReload(from: self.getList(wk: car?.wkda ?? [:]))
                        self.delegate?.onFetchCompleted(with: indexPathsToReload, reachedFinalPage: isReachedToLast)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none, reachedFinalPage: isReachedToLast)
                    }
                }
            }else {
                self.delegate?.onFetchFailed(with: error?.localizedDescription ?? "Error occured", reachedFinalPage: self.checkIFReachedToLastPage(current: self.currentPage, total: self.totalPageCount))
            }
        }
    }
    
    func checkIFReachedToLastPage(current: Int, total: Int) -> Bool {
        if current == total{
            return true
        }
        return false
    }
    
    func calculateIndexPathsToReload(from newCars: [Car]) -> [IndexPath] {
      let startIndex = cars.count - newCars.count
      let endIndex = startIndex + newCars.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func getList(wk: [String: String]) -> [Car]{
        let sorted = wk.sorted {
            return $0.key < $1.key
        }
        var list = [Car]()
        for (_, value) in sorted {
            let manufacturerInfoList = Car(carModelName: value)
            list.append(manufacturerInfoList)
        }
        return list
    }
    
    deinit {
        print("CarViewModel deinitialized from memory")
    }
}

