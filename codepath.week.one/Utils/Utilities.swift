//
//  Utilities.swift
//  codepath.week.one
//
//  Created by Michael on 09/07/2021.
//

import Foundation

class Utilities {
    
    public func getApiKey() -> String {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        return plist?.object(forKey: "API_KEY") as! String
    }
    
}
