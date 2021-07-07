//
//  UIImageViewExt.swift
//  codepath.week.one
//
//  Created by Michael on 07/07/2021.
//

import UIKit

extension UIImageView {
    
    func loadImage(at urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
    
    
}
