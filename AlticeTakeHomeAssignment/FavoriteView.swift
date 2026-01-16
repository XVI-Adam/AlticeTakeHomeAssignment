//
//  FavoriteView.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import SwiftUI

struct FavoriteView: View {

    @EnvironmentObject var favoritesStore: FavoritesStore

    var body: some View {
        NavigationStack {
            Group {
                if favoritesStore.favorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 42))
                            .foregroundStyle(.secondary)

                        Text("No Favorites Yet")
                            .font(.headline)

                        Text("Like a movie to save it here.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(favoritesStore.favorites) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                FavoriteRow(movie: movie)
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let movie = favoritesStore.favorites[index]
                                favoritesStore.removeFavorite(movie)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

private struct FavoriteRow: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {

            if let path = movie.posterPath,
               let url = URL(string: "\(Constants.imageBaseURL)\(path)") {

                PosterImageView(
                    posterPath: movie.posterPath,
                    width: 50,
                    height: 75,
                    cornerRadius: 8
                )

            } else {
                Image(systemName: "photo")
                    .frame(width: 50, height: 75)
                    .foregroundStyle(.secondary)
            }


            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)

                if let release = movie.releaseDate, !release.isEmpty {
                    Text(release)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}
