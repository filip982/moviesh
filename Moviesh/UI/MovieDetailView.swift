//
//  MovieDetailView.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 06.11.23.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                    } placeholder: {
                    }
                    .frame(width: 200.0, height: 200.0 * 1.5)
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movie.yearText)
                        .font(.title3)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                }
                
                Text(movie.overview)
                    .font(.title3)
                    .padding()
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

