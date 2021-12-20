//
//  ManufacturerViewModel.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/12/21.
//

import Foundation

final class ManufacturerViewModel {
    
    weak var delegate: CarManufacturerViewModelDelegate?
    let request: ManufacturerRequest
    
    var currentCount: Int {
        return manufacturers.count
    }
    
    func manufacturer(at index: Int) -> Manufacturer {
        return manufacturers[index]
    }
    
    private var isFetchInProgress = false
    private var currentPage = 0
    private var totalPageCount: Int = 1
    
    var manufacturers: [Manufacturer] = []
    
    init(request: ManufacturerRequest, delegate: CarManufacturerViewModelDelegate){
        self.request = request
        self.delegate = delegate
    }
    
    func fetchManufacturers() {
        guard !isFetchInProgress, currentPage < totalPageCount else {
            return
        }
        
        isFetchInProgress = true
        
        RequestHandler().requestList(with: request.self, page: currentPage) {[unowned self] manufacturer, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.totalPageCount = manufacturer?.totalPageCount ?? 0
                    self.manufacturers.append(contentsOf: self.getList(wk: manufacturer?.wkda ?? [:]))
                    let isReachedToLast = self.checkIFReachedToLastPage(current: self.currentPage, total: self.totalPageCount)
                    if manufacturer?.page ?? 0 >= 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: self.getList(wk: manufacturer?.wkda ?? [:]))
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
    
    func calculateIndexPathsToReload(from newManufacturers: [Manufacturer]) -> [IndexPath] {
        let startIndex = manufacturers.count - newManufacturers.count
        let endIndex = startIndex + newManufacturers.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func getList(wk: [String: String]) -> [Manufacturer]{
        let sorted = wk.sorted {
            return $0.key < $1.key
        }
        var list = [Manufacturer]()
        for (key, value) in sorted {
            let manufacturerInfoList = Manufacturer(manufacturerName: value, manufacturerIdValue: key)
            list.append(manufacturerInfoList)
        }
        return list
    }
    
    deinit {
        print("ManufacturerViewModel deinitialized from memory")
    }
}

