import SwiftUI

struct ParentSettingsView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        @Bindable var model = appModel
        NavigationStack {
            Form {
                Section("Play") {
                    Picker("Objects in a picture", selection: $model.targetLimit) {
                        Text("3 objects").tag(3)
                        Text("4 objects").tag(4)
                        Text("5 objects").tag(5)
                    }
                    Toggle("Show written prompt for co-play", isOn: $model.promptTextEnabled)
                    Toggle("Reduced movement", isOn: $model.reducedStimulation)
                }

                Section("Privacy") {
                    Text("Progress stays on this iPad. This version does not use a microphone, account, ads, analytics, or online play service.")
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") { appModel.route = .parentDashboard }
                }
            }
        }
    }
}
