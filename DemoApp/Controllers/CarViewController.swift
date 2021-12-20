//
//  CarViewController.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 11/12/2021.
//

import UIKit


class CarViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static var identifier: String{
        return String(describing: self)
    }
    
    var manufacturer: Manufacturer?
    
    private var carViewModel: CarViewModel?
    private var reachedFinalPage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setupActivityIndicator()
        
        let request = CarModelRequest.create(with: manufacturer?.manufacturerId ?? "")
        carViewModel = CarViewModel.init(request: request, manufacturer: manufacturer, delegate: self)
        carViewModel?.fetchCars()
    }
    
    fileprivate func setupActivityIndicator(){
        activityIndicator.color = UIColor(named: ColorPalate.activityIndicatorColor.rawValue)
        activityIndicator.startAnimating()
    }
    
    fileprivate func registerCell() {
        tableView.register(UINib(nibName: CarManufacturerCell.identifier, bundle: nil), forCellReuseIdentifier: CarManufacturerCell.identifier)
    }
    
    fileprivate func removeActivityIndicatorAfterFetchCompletion() {
        tableView.tableFooterView = nil
    }
    
    deinit {
        print("CarViewController deinitialized from memory")
    }
}

// MARK: UITableView delegate and dataSource
extension CarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarManufacturerCell.identifier) as? CarManufacturerCell else {return UITableViewCell()}
        cell.indexPath = indexPath
        cell.car = carViewModel?.car(at: indexPath.row)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carViewModel?.cars.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CarManufacturerCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertAction = UIAlertAction(title: StringConstants.okButtonTitle.rawValue, style: .default)
        displayAlert(with: StringConstants.carModel.rawValue, message: carViewModel?.getAlertTitle(at: indexPath.row) ?? "", actions: [alertAction])
    }
}

// MARK: ScrollView delegate
extension CarViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - SpinnerFooterView().height - scrollView.frame.size.height{
            guard let carVM = carViewModel else {return}
            if !reachedFinalPage {
                tableView.tableFooterView = SpinnerFooterView().createSpinnerFooterView()
            }
            carVM.fetchCars()
        }
    }
}

// MARK: CarManufacturerViewModel delegate
extension CarViewController: CarManufacturerViewModelDelegate{
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?, reachedFinalPage: Bool) {
        self.reachedFinalPage = reachedFinalPage
        removeActivityIndicatorAfterFetchCompletion()
        guard let newIndexPaths = newIndexPathsToReload else {
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        tableView.insertRows(at: newIndexPaths, with: .bottom)
    }
    
    func onFetchFailed(with reason: String, reachedFinalPage: Bool) {
        self.reachedFinalPage = reachedFinalPage
        
        let title = StringConstants.networkErrorApology.rawValue
        let action = UIAlertAction(title: StringConstants.okButtonTitle.rawValue, style: .default)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.removeActivityIndicatorAfterFetchCompletion()
            self.displayAlert(with: title , message: reason, actions: [action])
        }
    }
}

// MARK: Navigatable protocol
extension CarViewController: Navigatable{
    static var storyboardName: String {
        return Storyboards.main.rawValue
    }
    
    static var storyboardId: String {
        return CarViewController.identifier
    }
}

