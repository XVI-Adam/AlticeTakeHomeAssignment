//
//  FavoriteStore.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation
import Combine

@MainActor
final class FavoritesStore: ObservableObject {

    @Published private(set) var favorites: [Movie] = []

    private let storageKey = "favorite_movies"

    init() {
        load()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            favorites.removeAll { $0.id == movie.id }
        } else {
            favorites.append(movie)
        }
        save()
    }

    func removeFavorite(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
        save()
    }

    func clearAll() {
        favorites.removeAll()
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("❌ Failed to save favorites: \(error)")
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }

        do {
            favorites = try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            print("❌ Failed to load favorites: \(error)")
        }
    }
}

