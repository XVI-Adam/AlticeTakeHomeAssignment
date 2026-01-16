//
//  MovieDetails.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation

struct MovieDetails: Decodable, Identifiable {
    var id: Int
    var title: String
    var overview: String?
    var poster_path: String?
    var backdrop_path: String?
    var release_date: String?
    var vote_average: Double?
    var runtime: Int?
}
