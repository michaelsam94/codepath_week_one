// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nowPlayingRes = try? newJSONDecoder().decode(NowPlayingRes.self, from: jsonData)

import Foundation

// MARK: - NowPlayingRes
struct NowPlayingRes: Codable {
    let dates: Dates?
    let page: Int?
    let results: [Result]?
    let total_pages, total_results: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case total_pages
        case total_results
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double?
    let poster_path, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case genreIDS
        case id
        case originalLanguage
        case originalTitle
        case overview, popularity
        case poster_path
        case releaseDate
        case title, video
        case voteAverage
        case voteCount
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
}
