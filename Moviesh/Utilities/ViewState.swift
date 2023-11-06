//
//  ViewState.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 05.11.23.
//

import SwiftUI

enum ViewState<Model> {
    case loading
    case presenting(Model)
    case failure(Error)
    case noData
}

struct ViewStateView<Content: View, T>: View {
    
    let content: (T) -> Content
    let viewState: ViewState<T>
    var reloadAction: () -> Void
    
    init(
        viewState: ViewState<T>,
        @ViewBuilder _ content: @escaping (T) -> Content,
        reloadAction: @escaping () -> Void
    ) {
        self.content = content
        self.viewState = viewState
        self.reloadAction = reloadAction
    }
    
    var body: some View {
        switch viewState {
        case .loading:
            return AnyView(ProgressView { Text("Loading").foregroundColor(.gray).bold() })
        case .presenting(let result):
            return AnyView(content(result))
        case .failure(let error):
            return AnyView(ErrorView(errorTitle: error.localizedDescription, reloadAction: reloadAction))
        case .noData:
            return AnyView(NoDataView())
        }
    }
}

struct ErrorView: View {
    let errorTitle: String
    var reloadAction: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.gray)
            .overlay {
                VStack {
                    Text(errorTitle)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Button("Reload") {
                        reloadAction()
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
    }
}

struct NoDataView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.gray)
            .overlay {
                VStack {
                    Text("No data available")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
            }
    }
}

