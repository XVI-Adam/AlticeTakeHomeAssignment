//
//  MovieDetailView.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//
import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                PosterImageView(
                    posterPath: movie.posterPath,
                    width: 320,
                    height: 480,
                    cornerRadius: 14
                )
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .bold()

                    if let overview = movie.overview, !overview.isEmpty {
                        Text(overview)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    if let rating = movie.voteAverage {
                        Text(String(format: "⭐️ %.1f", rating))
                            .font(.headline)
                    }

                    if let releaseDate = movie.releaseDate {
                        Text("Released: \(releaseDate)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            FavoriteButton(movie: movie)
        }
    }
}
