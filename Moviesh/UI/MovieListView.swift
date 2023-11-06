//
//  ContentView.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 01.11.23.
//

import SwiftUI

// MARK: - View

struct MovieListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        ViewStateView(
            viewState: viewModel.viewState
        ) { movies in
            NavigationStack {
                List(movies, id: \.id) { movie in
                    NavigationLink(value: movie) {
                        MoviewListRowView(movie: movie)
                    }
                }
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                        .navigationTitle(movie.title)
                }
            }
        } reloadAction: {
            Task { await viewModel.loadCurrentState() }
        }
        .task {
            await viewModel.loadCurrentState()
        }
    }
}

// MARK: - ViewModel

extension MovieListView {
    
    class ViewModel: ObservableObject {
        @Published var viewState: ViewState<[Movie]> = .loading
        
        let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
        }
        
        @MainActor
        func loadCurrentState() async {
            do {
                let response = try await container.services.moviesService.fetchMovieList()
                let movies = response.results
                self.viewState = movies.count > 0 ? .presenting(movies) : .noData
            } catch {
                viewState = .failure(error)
            }
        }
    }
}


#Preview {
    MovieListView(viewModel: MovieListView.ViewModel(container: .preview))
}
