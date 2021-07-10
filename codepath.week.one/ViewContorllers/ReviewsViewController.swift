//
//  ReviewsViewController.swift
//  codepath.week.one
//
//  Created by Michael on 10/07/2021.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var reviewTextView: UITextView!
    
    var review: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTextView.text = review
    }
}
