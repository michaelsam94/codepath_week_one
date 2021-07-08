//
//  NowPlayingViewController.swift
//  codepath.week.one
//
//  Created by Michael on 07/07/2021.
//

import UIKit
import Alamofire

let baseUrl = "https://api.themoviedb.org/3/"
let apiKey = "6bdd92e829e5beb0f2902f834db79e10"

class NowPlayingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescTextView: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieImageView.cancelImageLoad()
    }
}


class NowPlayingViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var nowPlayingTableView: UITableView!
    
    var movies: [Result]? = []
    
    private var currentPage = 1
    private var totalNumberOfMovies = 1
    private var isFetchInProgress = false
    private var numOfLoadedMovies = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingTableView.delegate = self
        nowPlayingTableView.dataSource = self
        fetchMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfLoadedMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "NowPlayingTableViewCell") as? NowPlayingTableViewCell
        cell?.selectionStyle = .none
        print("row \(indexPath.row)")
        if isLoadingCell(for: indexPath) {
            if totalNumberOfMovies > numOfLoadedMovies {
                fetchMovies()
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let nowPlayingCell = cell as? NowPlayingTableViewCell
        nowPlayingCell?.movieTitleLabel.text = movies?[indexPath.row].title ?? "no title"
        nowPlayingCell?.movieDescTextView.text = movies?[indexPath.row].overview ?? "no overview"
        if let imagePath = movies?[indexPath.row].poster_path {
            nowPlayingCell?.movieImageView?.loadImage(at: "https://image.tmdb.org/t/p/w154\(imagePath)")
            print("imagepath https://image.tmdb.org/t/p/w154\(imagePath)")
        }
    }
    

    
}


extension NowPlayingViewController {
    func fetchMovies() {
        guard !self.isFetchInProgress else {
            return
        }
        
        self.isFetchInProgress = true
        
        let request = AF.request("\(baseUrl)movie/now_playing?api_key=\(apiKey)&page=\(self.currentPage)")
        request.responseDecodable(of: NowPlayingRes.self) { (response) in
            guard let nowPlayingResponse = response.value else { return }
            
            self.currentPage += 1
            self.isFetchInProgress = false
            self.numOfLoadedMovies += nowPlayingResponse.results?.count ?? 0
            
            self.totalNumberOfMovies = nowPlayingResponse.total_results ?? 1
            self.movies?.append(contentsOf: nowPlayingResponse.results ?? [])
            
            self.nowPlayingTableView.reloadData()
            
            if nowPlayingResponse.page ?? 1 > 1 {
                let indexPathsToBeReload = self.calculateIndexPathsToReload(from: nowPlayingResponse.results ?? [])
                self.nowPlayingTableView.reloadRows(at: indexPathsToBeReload, with: .automatic)
            }
            
            
            
        }
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
        let indexPathsForVisibleRows = self.nowPlayingTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
