//
//  MovieService.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 05.11.23.
//

import Foundation

protocol IMoviesService {
    func fetchMovieList() async throws -> MovieResponse
    func fetchMovieDetails(id: Int) async throws -> Movie
}

class MoviesService: IMoviesService {
    
    private var moviesRepo: IMoviesRepository
    
    init(
        moviesRepo: IMoviesRepository
    ) {
        self.moviesRepo = moviesRepo
    }
    
    func fetchMovieList() async throws -> MovieResponse {
        return try await moviesRepo.fetchMovies()
    }
    
    func fetchMovieDetails(id: Int) async throws -> Movie {
        throw MovieError.notImplemented
    }
}

// MARK: - Stubbed

struct StubMoviesService: IMoviesService {
    
    func fetchMovieList() async throws -> MovieResponse {
        throw MovieError.notImplemented
    }
    
    func fetchMovieDetails(id: Int) async throws -> Movie {
        throw MovieError.notImplemented
    }
}


