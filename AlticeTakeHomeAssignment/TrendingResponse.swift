//
//  TrendingResponse.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation

struct TrendingResponse : Decodable {
    var page: Int
    var results: [Movie]
}
