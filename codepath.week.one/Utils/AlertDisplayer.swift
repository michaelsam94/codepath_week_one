//
//  AlertDisplayer.swift
//  codepath.week.one
//
//  Created by Michael on 10/07/2021.
//

import Foundation
import UIKit
import Alamofire

protocol AlertDisplayer {
    func displayAlert(title: String,message: String,actions: [UIAlertAction]?)
}

extension AlertDisplayer where Self: UIViewController {

    func displayAlert(title: String,message: String,actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
    
    func startNetworkMonitoring() {
        let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.displayAlert(title: "netowrk conection", message: "network connection error", actions: [UIAlertAction(title: "Ok",style: .default,handler: { (actions) in
                    self.dismiss(animated: true, completion: nil)
                })])
            case .reachable(.cellular):
                self.dismiss(animated: true, completion: nil)
            case .reachable(.ethernetOrWiFi):
                self.dismiss(animated: true, completion: nil)
            case .unknown:
                print("Unknown network state")
            }
        }
    }
    
}
