import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TrendingViewModel()
    @State private var selectedWindow: TimeWindow = .day

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                Picker("Time Window", selection: $selectedWindow) {
                    ForEach(TimeWindow.allCases) { window in
                        Text(window.title).tag(window)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Group {
                    if viewModel.isLoading && viewModel.movies.isEmpty {
                        ProgressView("Loading trending...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack(spacing: 12) {
                            Text("Something went wrong")
                                .font(.headline)

                            Text(errorMessage)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)

                            Button("Retry") {
                                Task { await viewModel.load(window: selectedWindow.apiValue) }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List(viewModel.movies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                MovieRow(movie: movie)
                            }
                        }
                        .listStyle(.plain)
                        .refreshable {
                            await viewModel.load(window: selectedWindow.apiValue)
                        }
                    }
                }
            }
            .navigationTitle("Trending")
            .task {
                await viewModel.load(window: selectedWindow.apiValue)
            }
            .onChange(of: selectedWindow) { _, newValue in
                Task { await viewModel.load(window: newValue.apiValue) }
            }
        }
    }
}

enum TimeWindow: String, CaseIterable, Identifiable {
    case day
    case week

    var id: String { rawValue }

    var title: String {
        switch self {
        case .day: return "Today"
        case .week: return "This Week"
        }
    }

    var apiValue: String { rawValue }
}

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {
            PosterImageView(
                posterPath: movie.posterPath,
                width: 70,
                height: 105,
                cornerRadius: 10
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)

                if let releaseDate = movie.releaseDate {
                    Text("Release: \(releaseDate)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if let rating = movie.voteAverage {
                    Text(String(format: "Rating: %.1f", rating))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
            FavoriteButton(movie: movie)
        }
        .padding(.vertical, 6)
    }
}


