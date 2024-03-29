//
//  FecaliusApp.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import SwiftUI
import SwiftData

@main
struct FecaliusApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            Poop.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MapView()
        }
        .modelContainer(sharedModelContainer)
    }
}
