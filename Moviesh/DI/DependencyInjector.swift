//
//  DependencyInjector.swift
//  Moviesh
//
//  Created by Filip Miladinovic on 06.11.23.
//

import SwiftUI

struct DIContainer: EnvironmentKey {
    
    let services: Services

    static var defaultValue: Self { Self.default }
    
    private static let `default` = DIContainer(services: .stub)

    init(services: DIContainer.Services) {
        self.services = services
    }
}

extension DIContainer {
    static var preview: Self {
        .init(services: .stub)
    }
}
