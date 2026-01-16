//
//  FavoriteButton.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import SwiftUI

struct FavoriteButton: View {

    @EnvironmentObject var favoritesStore: FavoritesStore
    let movie: Movie

    var body: some View {
        Button {
            favoritesStore.toggleFavorite(movie)
        } label: {
            Image(systemName: favoritesStore.isFavorite(movie) ? "heart.fill" : "heart")
                .foregroundStyle(favoritesStore.isFavorite(movie) ? .red : .secondary)
        }
        .buttonStyle(.borderless)

    }
}

