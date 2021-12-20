//
//  SpinnerFooterView.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/10/21.
//

import Foundation
import UIKit

struct SpinnerFooterView{
    
    var height: CGFloat{
        return 100
    }
    
    /*
    Create a footerview with an activity indicator at the bottom of the tableview to inform the user that a pagination call has been made.
     */
    func createSpinnerFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}
