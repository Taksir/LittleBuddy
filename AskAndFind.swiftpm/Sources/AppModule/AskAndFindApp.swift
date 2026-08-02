import SwiftUI

@main
struct AskAndFindPlaygroundApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var progress = ProgressStore()
    @StateObject private var storyProgress = StoryProgressStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(progress)
                .environmentObject(storyProgress)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var progress: ProgressStore
    @EnvironmentObject private var storyProgress: StoryProgressStore

    var body: some View {
        switch appState.route {
        case .home:
            ActivityHomeView()
        case .play(let token):
            GameScreen(
                sessionToken: token,
                targetLimit: appState.targetLimit,
                progress: progress
            )
        case .storyLibrary:
            StoryLibraryView()
        case .story(let storyID, let token):
            if let book = StoryCatalog.book(id: storyID) {
                StoryTimeView(book: book, sessionToken: token, progress: storyProgress)
                    .id("\(storyID)-\(token.uuidString)")
            } else {
                ActivityHomeView()
            }
        case .storySequencerLibrary:
            StorySequencerLibraryView()
        case .storySequencer(let storyID, let level, let token):
            if let book = StoryCatalog.book(id: storyID) {
                StorySequencerView(book: book, level: level, sessionToken: token)
                    .id("sequencer-\(storyID)-\(token.uuidString)")
            } else {
                StorySequencerLibraryView()
            }
        case .audioRiddles:
            AudioRiddleView()
        case .parentGate(let destination):
            ParentGateView(destination: destination)
        case .dashboard:
            StoryParentDashboardView()
        case .settings:
            SettingsView()
        }
    }
}
