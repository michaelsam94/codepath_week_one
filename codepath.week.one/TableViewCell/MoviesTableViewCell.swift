//
//  MoviesTableViewCell.swift
//  codepath.week.one
//
//  Created by Michael on 10/07/2021.
//

import Foundation
import UIKit

class MoviesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescTextView: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieImageView.cancelImageLoad()
    }
}
