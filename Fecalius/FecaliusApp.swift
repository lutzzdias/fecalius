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
    var container: ModelContainer = {
        let schema = Schema([Poop.self])
        let config = ModelConfiguration(schema: schema)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MapView()
        }
        .modelContainer(container)
    }
}
