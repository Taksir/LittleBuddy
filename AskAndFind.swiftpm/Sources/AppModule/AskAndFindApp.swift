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
        case .story(let token):
            StoryTimeView(sessionToken: token, progress: storyProgress)
        case .parentGate(let destination):
            ParentGateView(destination: destination)
        case .dashboard:
            StoryParentDashboardView()
        case .settings:
            SettingsView()
        }
    }
}
