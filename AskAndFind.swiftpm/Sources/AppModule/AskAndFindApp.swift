import SwiftUI

@main
struct AskAndFindPlaygroundApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var progress = ProgressStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(progress)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var progress: ProgressStore

    var body: some View {
        switch appState.route {
        case .home:
            HomeView()
        case .play(let token):
            GameScreen(sessionToken: token, targetLimit: appState.targetLimit, progress: progress)
        case .parentGate(let destination):
            ParentGateView(destination: destination)
        case .dashboard:
            ParentDashboardView()
        case .settings:
            SettingsView()
        }
    }
}
