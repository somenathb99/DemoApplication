//
//  Navigatable.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 10/10/21.
//

import Foundation
import UIKit

protocol Navigatable {
    static var storyboardName: String { get }
    static var storyboardId: String { get }
    static func instantiateFromStoryboard() -> Self
}

extension Navigatable {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        guard
            let viewController = storyboard
                .instantiateViewController(withIdentifier: self.storyboardId) as? Self else {
                    fatalError("Cannot instantiate the controller.")
        }

        return viewController
    }
}
