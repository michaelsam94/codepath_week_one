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
    
    var nowPlayingMoviesRes: NowPlayingRes? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        nowPlayingTableView.delegate = self
        nowPlayingTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nowPlayingMoviesRes?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "NowPlayingTableViewCell") as? NowPlayingTableViewCell
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let nowPlayingCell = cell as? NowPlayingTableViewCell
        nowPlayingCell?.movieTitleLabel.text = nowPlayingMoviesRes?.results?[indexPath.row].title ?? "no title"
        nowPlayingCell?.movieDescTextView.text = nowPlayingMoviesRes?.results?[indexPath.row].overview ?? "no overview"
        if let imagePath = nowPlayingMoviesRes?.results?[indexPath.row].poster_path {
            nowPlayingCell?.movieImageView?.loadImage(at: "https://image.tmdb.org/t/p/w154\(imagePath)")
            print("imagepath https://image.tmdb.org/t/p/w154\(imagePath)")
        }
    }
    
}


extension NowPlayingViewController {
    func fetchMovies() {
        let request = AF.request("\(baseUrl)movie/now_playing?api_key=\(apiKey)")
        request.responseDecodable(of: NowPlayingRes.self) { (response) in
            guard let nowPlayingResponse = response.value else { return }
            self.nowPlayingMoviesRes = nowPlayingResponse
            self.nowPlayingTableView.reloadData()
        }
    }
}
