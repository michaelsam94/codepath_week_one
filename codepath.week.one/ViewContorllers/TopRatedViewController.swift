//
//  TopRatedViewController.swift
//  codepath.week.one
//
//  Created by Michael on 07/07/2021.
//

import UIKit
import RappleProgressHUD


class TopRatedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var topRatedMoviesTableView: UITableView!
    
    
    var movies: [Result]? = []
    
    private var currentPage = 1
    private var totalNumberOfMovies = 1
    private var numOfLoadedMovies = 0
    
    
    private var isFetchInProgress = false {
        didSet {
            if isFetchInProgress {
                RappleActivityIndicatorView.startAnimating()
            } else {
                RappleActivityIndicatorView.stopAnimation()
                refreshControl.endRefreshing()
            }
        }
    }
    
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topRatedMoviesTableView.delegate = self
        topRatedMoviesTableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        topRatedMoviesTableView?.addSubview(refreshControl)
        fetchMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailsSegue" {
            let cell = sender as! UITableViewCell
            if let index = topRatedMoviesTableView.indexPath(for: cell) {
                let movieDetailsVC = segue.destination as! MovieDetailsViewController
                movieDetailsVC.movieId = movies?[index.row].id
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfLoadedMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "moviesTableViewCell") as? MoviesTableViewCell
        cell?.selectionStyle = .none
        //print("row \(indexPath.row)")
        if isLoadingCell(for: indexPath) {
            if totalNumberOfMovies > numOfLoadedMovies {
                fetchMovies()
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let nowPlayingCell = cell as? MoviesTableViewCell
        nowPlayingCell?.movieTitleLabel.text = movies?[indexPath.row].title ?? "no title"
        nowPlayingCell?.movieDescTextView.text = movies?[indexPath.row].overview ?? "no overview"
        if let imagePath = movies?[indexPath.row].poster_path {
            nowPlayingCell?.movieImageView?.loadImage(at: "\(posterBaseUrl)\(imagePath)")
            //print("imagepath https://image.tmdb.org/t/p/w154\(imagePath)")
        }
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        currentPage = 1
        numOfLoadedMovies = 0
        movies?.removeAll()
        fetchMovies()
    }
    

    
}


extension TopRatedViewController {
    func fetchMovies() {
        guard !self.isFetchInProgress else {
            return
        }
        self.isFetchInProgress = true
        
        NetworkOperations().getTopRatedMovies(page: currentPage, completionsHandler: {(respone) in
            self.currentPage += 1
            self.isFetchInProgress = false
            self.numOfLoadedMovies += respone.results?.count ?? 0
            
            self.totalNumberOfMovies = respone.total_results ?? 1
            self.movies?.append(contentsOf: respone.results ?? [])
            
            self.topRatedMoviesTableView.reloadData()
            
            if respone.page ?? 1 > 1 {
                let indexPathsToBeReload = self.calculateIndexPathsToReload(from: respone.results ?? [])
                self.topRatedMoviesTableView.reloadRows(at: indexPathsToBeReload, with: .automatic)
            }
        })
    }
    
    
    func calculateIndexPathsToReload(from newMovies: [Result]) -> [IndexPath] {
        let startIndex = (self.movies?.count ?? 0) - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == numOfLoadedMovies - 1
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = self.topRatedMoviesTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
