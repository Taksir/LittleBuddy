import SwiftUI

struct GameplayView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let engine: GameplayEngine

    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.97, blue: 0.88).ignoresSafeArea()
            VStack(spacing: 12) {
                header
                StorybookSceneView(
                    scene: engine.scene,
                    currentTarget: engine.currentTarget,
                    highlightedTargetID: engine.phase == .showingHint || engine.phase == .demonstrating ? engine.currentTarget?.id : engine.foundTargetID,
                    showHandPointer: engine.phase == .showingHint || engine.phase == .demonstrating,
                    reducedMotion: reduceMotion || appModel.reducedStimulation,
                    onTap: engine.handleTap
                )
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 28, style: .continuous).stroke(.white, lineWidth: 5))
                .padding(.horizontal, 20)
                .accessibilityIdentifier("storybookScene")
                feedbackPanel
            }
            .padding(.vertical, 16)
        }
        .onAppear { engine.start() }
    }

    private var header: some View {
        HStack(spacing: 16) {
            Button { appModel.route = .home } label: {
                Image(systemName: "house.fill").font(.title2.bold()).frame(width: 64, height: 56)
            }
            .buttonStyle(RuntimeChildControlStyle())
            .accessibilityIdentifier("homeButton")
            Spacer()
            VStack(spacing: 2) {
                if appModel.promptTextEnabled, let target = engine.currentTarget {
                    Text(target.question).font(.title2.bold()).lineLimit(1)
                } else {
                    Text("Listen carefully").font(.title2.bold())
                }
                Text(engine.progressText).font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
            }
            .frame(maxWidth: 520)
            .padding(.horizontal, 22).padding(.vertical, 12)
            .background(.white, in: Capsule())
            Spacer()
            Button { engine.replayInstruction() } label: {
                Image(systemName: "speaker.wave.2.fill").font(.title2.bold()).frame(width: 64, height: 56)
            }
            .buttonStyle(RuntimeChildControlStyle())
            .accessibilityIdentifier("replayInstruction")
        }
        .padding(.horizontal, 20)
    }

    private var feedbackPanel: some View {
        VStack(spacing: 10) {
            Text(engine.feedbackText.isEmpty ? "Tap the picture when you find it." : engine.feedbackText)
                .font(.title3.weight(.semibold))
                .foregroundStyle(Color(red: 0.08, green: 0.26, blue: 0.35))
                .multilineTextAlignment(.center)
                .frame(minHeight: 30)
            if engine.phase == .completed {
                HStack(spacing: 16) {
                    Button("Another picture") { beginAnotherPicture() }.buttonStyle(.borderedProminent)
                    Button("Home") { appModel.route = .home }.buttonStyle(.bordered)
                }
                .font(.title3.bold())
            }
        }
        .padding(.horizontal, 24).padding(.bottom, 4)
    }

    private func beginAnotherPicture() {
        appModel.route = .home
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(50))
            guard !Task.isCancelled else { return }
            appModel.route = .play
        }
    }
}

private struct RuntimeChildControlStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color(red: 0.10, green: 0.32, blue: 0.58))
            .background(.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .shadow(color: .black.opacity(0.12), radius: 5, y: 3)
    }
}
