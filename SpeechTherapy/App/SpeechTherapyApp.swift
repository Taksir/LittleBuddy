import SwiftUI
import SwiftData

@main
struct SpeechTherapyApp: App {
    private let modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: LearningEventRecord.self)
        } catch {
            fatalError("Unable to create the local progress store: \(error)")
        }
    }()

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appModel)
        }
        .modelContainer(modelContainer)
    }
}
