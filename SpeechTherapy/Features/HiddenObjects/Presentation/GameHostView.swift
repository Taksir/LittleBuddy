import SwiftUI
import SwiftData

struct GameHostView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.modelContext) private var modelContext
    @State private var engine: GameplayEngine?
    @State private var loadError: String?

    var body: some View {
        Group {
            if let engine {
                GameplayView(engine: engine)
            } else if let loadError {
                SafeErrorView(message: loadError) {
                    appModel.route = .home
                }
            } else {
                ProgressView("Getting the picture ready…")
                    .font(.title3.weight(.medium))
            }
        }
        .task {
            guard engine == nil, loadError == nil else { return }
            do {
                let pack = try BundledSceneCatalog.load()
                guard let scene = pack.scenes.randomElement() else { throw ContentValidationError.wrongSceneCount(0) }
                let seed = UInt64(Date.now.timeIntervalSince1970 * 1_000)
                engine = GameplayEngine(
                    scene: scene,
                    pack: pack,
                    targetLimit: appModel.targetLimit,
                    seed: seed,
                    audio: SystemAudioGuidance(),
                    progress: SwiftDataProgressRepository(context: modelContext)
                )
                engine?.start()
            } catch {
                loadError = error.localizedDescription
            }
        }
        .onDisappear { engine?.endSessionIfNeeded() }
    }
}

private struct SafeErrorView: View {
    let message: String
    let onHome: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Let’s try another picture soon.")
                .font(.largeTitle.bold())
            Text(message)
                .foregroundStyle(.secondary)
            Button("Back home", action: onHome)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
