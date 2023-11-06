//
//  TMDBRepository.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 04.11.23.
//

import Foundation

// MARK: - Http Endpoints

enum MovieEndpoint: String, CaseIterable, Identifiable {
        
    var id: String { rawValue }
    
    /// Find movies using over 30 filters and sort options. Link: https://developer.themoviedb.org/reference/discover-movie
    case discover = "discover/movie"
    /// Get the top level details of a movie by ID. Link: https://developer.themoviedb.org/reference/movie-details
    case movieDetails = "movie/@%"
    
    var description: String {
        switch self {
        case .discover: return "Discover"
        case .movieDetails: return "Movie Details"
        }
    }
}

// MARK: - Interface

protocol IMoviesRepository {
    func fetchMovies() async throws -> MovieResponse
    func fetchMovie(id: Int) async throws -> Movie
}

// MARK: - Implementation of Service

struct MoviesRepository: IMoviesRepository {
    
    var httpClient: HttpClient
    
    init(
        httpClient: HttpClient
    ) {
        self.httpClient = httpClient
    }
    
    func fetchMovies() async throws -> MovieResponse {
        let path = MovieEndpoint.discover.rawValue
        let response: MovieResponse = try await httpClient.get(path: path)
        return response
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        let path = String(format: MovieEndpoint.movieDetails.rawValue, String(id))
        let response: Movie = try await httpClient.get(path: path)
        return response
    }
}

// MARK: - Errors

enum MovieError: Error, CustomNSError {
    
    case notImplemented
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .notImplemented: return "Still not yet implemented"
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
}
