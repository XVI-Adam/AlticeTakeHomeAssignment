//
//  TMDBClient.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation

struct TMDBClient {
    let tmdbBaseURL = APIConfig.shared.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared.tmdbAPIKey

    func fetchTrending(for timeWindow: String) async throws -> [Movie] {
        let endpoint = timeWindow == "week" ? Constants.trendingWeekEndpoint : Constants.trendingTodayEndpoint
        
        guard let baseURL = URL(string: tmdbBaseURL) else {
            throw NetworkError.missingConfig
        }
        
        guard let fetchTitlesURL = URL(string: "\(baseURL)\(endpoint)?api_key=\(tmdbAPIKey)&language=en-US&page=1") else {
            throw NetworkError.missingConfig
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchTitlesURL)
        guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.badURLResponse(underlyingError: URLError(.badServerResponse))
                }
        
        let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(TrendingResponse.self, from: data)
        
        return decodedResponse.results
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {

        guard let baseURL = URL(string: tmdbBaseURL) else {
            throw NetworkError.missingConfig
        }

        guard let detailsURL = URL(string: "\(baseURL)/movie/\(movieId)?api_key=\(tmdbAPIKey)&language=en-US") else {
            throw NetworkError.missingConfig
        }

        let (data, response) = try await URLSession.shared.data(from: detailsURL)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badURLResponse(underlyingError: URLError(.badServerResponse))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let decoded = try decoder.decode(MovieDetails.self, from: data)
        return decoded
    }

}
