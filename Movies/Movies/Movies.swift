// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// список фильмов
struct MovieList: Codable {
    let results: [Result]
}

/// модель фильмов
struct Result: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
