//
//  AppDelegate.swift
//  codepath.week.one
//
//  Created by Michael on 07/07/2021.
//

import UIKit
import AlamofireNetworkActivityLogger
import Reachability
import RappleProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var reachablility: Reachability?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(checkForReachablility), name: NSNotification.Name.reachabilityChanged, object: nil)
        self.reachablility = Reachability.forInternetConnection()
        self.reachablility?.startNotifier()
        
        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        #endif
        
        
        
        return true
    }
    
    @objc func checkForReachablility(notification: Notification){
        let networkReachability = notification.object as! Reachability
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        RappleActivityIndicatorView.stopAnimation()
        
        if !networkReachability.isReachable() {
            print("network connected")
            keyWindow?.rootViewController?.topMostViewController().dismiss(animated: true)
        } else {
            print("network not connected")
            let alertController = UIAlertController(title: "no network", message: "network concctions lost", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            keyWindow?.rootViewController?.topMostViewController().present(alertController,animated: true)
        }
        
    }
    
    
}

