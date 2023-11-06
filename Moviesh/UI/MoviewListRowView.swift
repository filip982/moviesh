//
//  MoviewListRowView.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 06.11.23.
//

import SwiftUI

struct MoviewListRowView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack (alignment: .top) {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
            } placeholder: {
                
            }
            .frame(width: 100.0, height: 150.0)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                HStack {
                    Text("Rating:")
                        .font(.subheadline)
                    Text(String(format: "%.2f", movie.voteAverage ))
                        .font(Font.subheadline)
                }
                HStack {
                    Text("Popularity")
                        .font(.subheadline)
                    Text(String(format: "%.2f", movie.popularity ?? 0))
                        .font(Font.subheadline)
                }
            }
        }
    }
}


//#Preview {
//    // TODO: Define stub for Movie
//    MoviewListRowView(movie: Movie.stub())
//}

