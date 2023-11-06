//
//  AppEnvironment.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 06.11.23.
//

import UIKit

struct AppEnvironment {
    let container: DIContainer
    
    static func bootstrap() -> AppEnvironment {
        let session = configuredURLSession()
        
        let webRepositories = configuredWebRepositories(session: session)
        let services = configuredServices(webRepositories: webRepositories)
        let diContainer = DIContainer(services: services)
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let moviesWebRepository = MoviesRepository(
            httpClient: HttpClient(
                session: session,
                baseURL: Constants.Movies.baseUrl,
                apiKey: Constants.Movies.apiKey
            )
        )
        return .init(moviesRepository: moviesWebRepository)
    }
    
    
    private static func configuredServices(
        webRepositories: DIContainer.WebRepositories
    ) -> DIContainer.Services {
        
        let moviesService = MoviesService(moviesRepo: webRepositories.moviesRepository)

        return .init(moviesService: moviesService)
    }
}

extension DIContainer {
    struct WebRepositories {
        let moviesRepository: IMoviesRepository
    }
    
    struct DBRepositories {
        // TBD
    }
}

