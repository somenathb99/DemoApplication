//
//  CarManufacturerViewModelDelegate.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/10/21.
//

import Foundation

/*
This protocol is responsible to delegate the events of completion of the url request that the viewmodels have made to the view controllers
*/
protocol CarManufacturerViewModelDelegate: AnyObject {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?, reachedFinalPage: Bool)
    func onFetchFailed(with reason: String, reachedFinalPage: Bool)
}
