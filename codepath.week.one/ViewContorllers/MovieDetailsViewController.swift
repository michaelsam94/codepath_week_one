//
//  MovieDetailsViewController.swift
//  codepath.week.one
//
//  Created by Michael on 09/07/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var generesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var trailesAndReviewTableView: UITableView!
    
    
    var movieId: Int?
    
    var reviews: ReviewsClass?
    var trailers: TrailersClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailesAndReviewTableView.dataSource = self
        trailesAndReviewTableView.delegate = self
        if let movieId = movieId {
            NetworkOperations().getMovieDetails(movieId: movieId, completionsHandler: {(movieDetails) in
                if let posterUrl = movieDetails.poster_path {
                    self.posterImageView.loadImage(at: "\(posterBaseUrl)\(posterUrl)")
                    self.movieTitleLabel.text = movieDetails.title!
                    var allGeneres: String = ""
                    for (genere) in movieDetails.genres! {
                        if genere == movieDetails.genres?.last { allGeneres.append(genere.name!) }
                        else {allGeneres.append("\(genere.name!), ")}
                    }
                    self.generesLabel.text = allGeneres
                    self.releaseDateLabel.text = movieDetails.release_date!
                    self.rateLabel.text = "\(String(movieDetails.vote_average!)) / 10.0"
                    self.runtimeLabel.text = "\(movieDetails.runtime!) Minutes"
                    self.descriptionTextView.text = movieDetails.overview!
                    self.reviews = movieDetails.reviews
                    self.trailers = movieDetails.trailers
                    self.trailesAndReviewTableView.reloadData()
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let trailersCount = trailers?.youtube?.count {
                return trailersCount
            }
        } else {
            if let reviewsCount = reviews?.results?.count {
                return reviewsCount
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if indexPath.section == 0 {
            cell?.textLabel?.text = trailers?.youtube?[indexPath.row].name
        } else {
            cell?.textLabel?.text = reviews?.results?[indexPath.row].author
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Trailers"
        } else {
            return "Reviews"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            openTrailer(index: indexPath.row)
        } else {
            dispalyReview(index: indexPath.row)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections = 0
        if trailers?.youtube != nil {numOfSections += 1}
        if reviews?.results != nil {numOfSections += 1}
        return numOfSections
    }
    
    func dispalyReview(index: Int){
        if let review = reviews?.results?[index] {
            performSegue(withIdentifier: "reviewSegue", sender: review)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewSegue" {
            let reviewVC = segue.destination as! ReviewsViewController
            if let review = sender as! Review? {
                reviewVC.review = review.content
            }
        }
    }
    
    func openTrailer(index: Int){
        if let trailerSource = trailers?.youtube?[index].source {
            let appUrl = URL(string: "youtube://\(trailerSource)")
            if UIApplication.shared.canOpenURL(appUrl!) {
                UIApplication.shared.open(appUrl!, options: [:], completionHandler: nil)
            } else {
                let webUrl = URL(string: "https://www.youtube.com/watch?v=\(trailerSource)")
                UIApplication.shared.open(webUrl!, options: [:], completionHandler: nil)
            }
        }
        
        
    }
    
    
}
