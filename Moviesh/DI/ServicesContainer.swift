//
//  ServicesContainer.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 06.11.23.
//

extension DIContainer {
    
    struct Services {
        let moviesService: IMoviesService
        
        init(
            moviesService: IMoviesService
        ) {
            self.moviesService = moviesService
        }
        
        static var stub: Self {
            .init(moviesService: StubMoviesService())
        }
    }
}
