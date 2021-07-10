//
//  UIViewControllerExt.swift
//  codepath.week.one
//
//  Created by Michael on 10/07/2021.
//

import Foundation
import UIKit


extension UIViewController {
    func topMostViewController() -> UIViewController {
            if let presented = self.presentedViewController {
                return presented.topMostViewController()
            }
            
            if let navigation = self as? UINavigationController {
                return navigation.visibleViewController?.topMostViewController() ?? navigation
            }
            
            if let tab = self as? UITabBarController {
                return tab.selectedViewController?.topMostViewController() ?? tab
            }
            
            return self
        }
}
