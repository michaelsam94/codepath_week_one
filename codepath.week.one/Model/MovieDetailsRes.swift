// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieDetailsRes = try? newJSONDecoder().decode(MovieDetailsRes.self, from: jsonData)

import Foundation

// MARK: - MovieDetailsRes
struct MovieDetailsRes: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: JSONNull?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let poster_path: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let release_date: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    let trailers: TrailersClass?
    let reviews: ReviewsClass?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case belongsToCollection
        case budget, genres, homepage, id
        case imdbID
        case originalLanguage
        case originalTitle
        case overview, popularity
        case poster_path
        case productionCompanies
        case productionCountries
        case release_date
        case revenue, runtime
        case spokenLanguages
        case status, tagline, title, video
        case vote_average
        case vote_count
        case trailers,reviews
    }
}

// MARK: - Genre
struct Genre: Codable,Equatable {
    let id: Int?
    let name: String?
    
    static func ==(lhs: Genre,rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath
        case name
        case originCountry
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName
        case iso639_1
        case name
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - Trailers
struct Trailers: Codable {
    let trailers: TrailersClass?
}

// MARK: - TrailersClass
struct TrailersClass: Codable {
    let youtube: [Youtube]?
}

// MARK: - Youtube
struct Youtube: Codable {
    let name, size, source, type: String?
}


// MARK: - Reviews
struct Reviews: Codable {
    let reviews: ReviewsClass?
}

// MARK: - ReviewsClass
struct ReviewsClass: Codable {
    let page: Int?
    let results: [Review]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages
        case totalResults
    }
}

// MARK: - Result
struct Review: Codable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails
        case content
        case createdAt
        case id
        case updatedAt
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username, avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath
        case rating
    }
}
