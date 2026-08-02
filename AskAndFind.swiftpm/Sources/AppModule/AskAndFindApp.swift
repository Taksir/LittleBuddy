import SwiftUI

@main
struct AskAndFindPlaygroundApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var progress = ProgressStore()
    @StateObject private var storyProgress = StoryProgressStore()
    @StateObject private var audioRiddleProgress = AudioRiddleProgressStore.shared
    @StateObject private var sequencerProgress = StorySequencerProgressStore.shared

    init() {
        #if DEBUG
        if !SceneCatalog.validationIssues.isEmpty {
            assertionFailure("SceneCatalog validation issues: \(SceneCatalog.validationIssues)")
        }
        if !StoryCatalog.validationIssues.isEmpty {
            assertionFailure("StoryCatalog validation issues: \(StoryCatalog.validationIssues)")
        }
        if !AudioRiddleCatalog.validationIssues.isEmpty {
            assertionFailure("AudioRiddleCatalog validation issues: \(AudioRiddleCatalog.validationIssues)")
        }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(progress)
                .environmentObject(storyProgress)
                .environmentObject(audioRiddleProgress)
                .environmentObject(sequencerProgress)
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
