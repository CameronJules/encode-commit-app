//
//  lilyApp.swift
//  lily
//
//  Created by Cameron Jules on 20/01/2026.
//

import SwiftUI
import SwiftData

@main
struct lilyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self,
            Subtask.self,
            Project.self,
            Character.self,
            Wallet.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Schema changed - delete old store and retry
            let url = URL.applicationSupportDirectory.appending(path: "default.store")
            try? FileManager.default.removeItem(at: url)
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
