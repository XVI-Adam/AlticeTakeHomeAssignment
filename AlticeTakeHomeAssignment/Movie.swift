//
//  Movie.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var overview: String?
    var posterPath: String?
    var voteAverage: Double?
    var releaseDate: String?
}
