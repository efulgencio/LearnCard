import SwiftUI

@main
struct LearnCardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: StudySet.self)
    }
}
