//
//  MovieshApp.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 01.11.23.
//

import SwiftUI

@main
struct MovieshApp: App {
    
    let environment = AppEnvironment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListView.ViewModel(container: environment.container))
        }
    }
}
