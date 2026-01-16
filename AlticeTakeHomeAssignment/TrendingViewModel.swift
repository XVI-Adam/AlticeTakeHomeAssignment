//
//  TrendingViewModel.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation
import Combine

@MainActor
final class TrendingViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service = FetchTrending()

    func load(window: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await service.fetchTrending(for: window)
            movies = result
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
