import SwiftUI

struct ParentGateView: View {
    @Environment(AppModel.self) private var appModel
    @State private var answer = ""
    @State private var showError = false

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.96, blue: 0.98).ignoresSafeArea()
            VStack(spacing: 22) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 58))
                    .foregroundStyle(.blue)
                Text("Grown-up check")
                    .font(.largeTitle.bold())
                Text("What is seven plus five?")
                    .font(.title2.weight(.medium))
                TextField("Answer", text: $answer)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 180)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .accessibilityIdentifier("parentGateAnswer")
                if showError {
                    Text("Try again, grown-up.")
                        .foregroundStyle(.red)
                }
                HStack(spacing: 16) {
                    Button("Back") { appModel.route = .home }
                        .buttonStyle(.bordered)
                    Button("Continue") {
                        if answer.trimmingCharacters(in: .whitespacesAndNewlines) == "12" {
                            appModel.route = appModel.parentGateReturnRoute
                        } else {
                            showError = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier("parentGateContinue")
                }
            }
            .padding(40)
            .background(.white, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 16, y: 8)
        }
    }
}
