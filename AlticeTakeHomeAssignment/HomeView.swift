import SwiftUI
import Combine

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
            poster
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)

                if let releaseDate = movie.release_date {
                    Text("Release: \(releaseDate)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if let rating = movie.vote_average {
                    Text(String(format: "Rating: %.1f", rating))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }

    private var poster: some View {
        Group {
            if let posterPath = movie.poster_path,
               let url = URL(string: "\(Constants.imageBaseURL)\(posterPath)") {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 70, height: 105)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 105)
                            .clipped()
                            .cornerRadius(10)

                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 70, height: 105)

                    @unknown default:
                        EmptyView()
                    }
                }

            } else {
                Image(systemName: "photo")
                    .frame(width: 70, height: 105)
            }
        }
    }
}

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                if let posterPath = movie.poster_path,
                   let url = URL(string: "\(Constants.imageBaseURL)\(posterPath)") {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(14)
                    .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .bold()

                    if let overview = movie.overview, !overview.isEmpty {
                        Text(overview)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    if let rating = movie.vote_average {
                        Text(String(format: "⭐️ %.1f", rating))
                            .font(.headline)
                    }

                    if let releaseDate = movie.release_date {
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
    }
}
