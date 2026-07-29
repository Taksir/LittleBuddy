import SwiftUI

struct RootView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        Group {
            switch appModel.route {
            case .home:
                HomeView()
            case .play:
                GameHostView()
            case .parentGate:
                ParentGateView()
            case .parentDashboard:
                ParentDashboardView()
            case .settings:
                ParentSettingsView()
            }
        }
        .tint(Color(red: 0.14, green: 0.37, blue: 0.66))
    }
}
