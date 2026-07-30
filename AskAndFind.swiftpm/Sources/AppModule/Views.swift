import SwiftUI
import UIKit

struct HomeView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.37, green: 0.77, blue: 0.92),
                    Color(red: 0.88, green: 0.96, blue: 0.71)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                Text("Ask & Find")
                    .font(.system(size: 54, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .blue.opacity(0.25), radius: 2, y: 2)

                Text("Listen, look, and find!")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.35))

                Button { appState.beginGame() } label: {
                    VStack(spacing: 14) {
                        Image(systemName: "sparkle.magnifyingglass")
                            .font(.system(size: 70, weight: .bold))
                        Text("Find Hidden Objects")
                            .font(.system(size: 29, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(Color(red: 0.07, green: 0.27, blue: 0.39))
                    .frame(width: 390, height: 205)
                    .background(.white.opacity(0.94), in: RoundedRectangle(cornerRadius: 34))
                    .shadow(color: .black.opacity(0.15), radius: 12, y: 7)
                }

                Spacer()
                HStack {
                    Spacer()
                    Button { appState.route = .parentGate(.dashboard) } label: {
                        Label("For grown-ups", systemImage: "lock.fill")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(.white.opacity(0.82), in: Capsule())
                    }
                }
                .padding(28)
            }
            .padding()
        }
    }
}

struct GameScreen: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.accessibilityReduceMotion) private var systemReduceMotion
    @StateObject private var engine: GameEngine

    init(sessionToken: UUID, targetLimit: Int, progress: ProgressStore) {
        let index = abs(sessionToken.hashValue) % SceneCatalog.scenes.count
        let scene = SceneCatalog.scenes[index]
        _engine = StateObject(
            wrappedValue: GameEngine(
                scene: scene,
                targetLimit: targetLimit,
                progress: progress
            )
        )
    }

    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.97, blue: 0.88)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                gameHeader

                StorybookSceneView(
                    scene: engine.scene,
                    highlightedTargetID: engine.highlightedTargetID,
                    showPreciseLocation: engine.phase == .demonstrating,
                    showSuccess: engine.phase == .celebrating,
                    reducedMovement: systemReduceMotion || appState.reducedMovement,
                    onTap: engine.handleTap
                )
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay {
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(.white, lineWidth: 5)
                }
                .shadow(color: .black.opacity(0.13), radius: 10, y: 5)
                .padding(.horizontal, 20)

                VStack(spacing: 10) {
                    Text(engine.feedback.isEmpty ? "Tap the picture when you find it." : engine.feedback)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(Color(red: 0.08, green: 0.26, blue: 0.35))
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 30)

                    if engine.phase == .completed {
                        HStack(spacing: 16) {
                            Button("Another picture") { appState.beginGame() }
                                .buttonStyle(.borderedProminent)
                            Button("Home") { appState.route = .home }
                                .buttonStyle(.bordered)
                        }
                        .font(.title3.bold())
                    }
                }
                .padding(.bottom, 4)
            }
            .padding(.vertical, 16)

            if engine.phase == .showingHint, let target = engine.currentTarget {
                ObjectPreviewOverlay(scene: engine.scene, target: target)
                    .transition(.scale(scale: 0.82).combined(with: .opacity))
                    .zIndex(10)
            }
        }
        .animation(
            (systemReduceMotion || appState.reducedMovement) ? nil : .spring(response: 0.38, dampingFraction: 0.82),
            value: engine.phase
        )
        .onAppear { engine.start() }
        .onDisappear { engine.stopAndSave() }
    }

    private var gameHeader: some View {
        HStack(spacing: 16) {
            Button { appState.route = .home } label: {
                Image(systemName: "house.fill")
                    .font(.title2.bold())
                    .frame(width: 64, height: 56)
            }
            .buttonStyle(ChildControlStyle())

            Spacer()

            VStack(spacing: 2) {
                if appState.promptTextEnabled, let target = engine.currentTarget {
                    Text(target.question)
                        .font(.title2.bold())
                        .lineLimit(1)
                } else {
                    Text("Listen carefully")
                        .font(.title2.bold())
                }
                Text(engine.progressText)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: 520)
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(.white, in: Capsule())

            Spacer()

            Button { engine.replay() } label: {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.title2.bold())
                    .frame(width: 64, height: 56)
            }
            .buttonStyle(ChildControlStyle())
        }
        .padding(.horizontal, 20)
    }
}

private struct ChildControlStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color(red: 0.10, green: 0.32, blue: 0.58))
            .background(.white, in: RoundedRectangle(cornerRadius: 18))
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .shadow(color: .black.opacity(0.12), radius: 5, y: 3)
    }
}

struct StorybookSceneView: View {
    let scene: StoryScene
    let highlightedTargetID: String?
    let showPreciseLocation: Bool
    let showSuccess: Bool
    let reducedMovement: Bool
    let onTap: (NormalizedPoint) -> Void

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(scene.imageName, bundle: .module)
                    .resizable()
                    .interpolation(.high)
                    .scaledToFit()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .accessibilityHidden(true)

                if let target = scene.targets.first(where: { $0.id == highlightedTargetID }) {
                    if showPreciseLocation {
                        PreciseLocationMarker(reducedMovement: reducedMovement)
                            .frame(
                                width: max(54, proxy.size.width * CGFloat(target.box.width) + 12),
                                height: max(54, proxy.size.height * CGFloat(target.box.height) + 12)
                            )
                            .position(
                                x: proxy.size.width * CGFloat(target.box.center.x),
                                y: proxy.size.height * CGFloat(target.box.center.y)
                            )
                    } else if showSuccess {
                        SuccessMarker(reducedMovement: reducedMovement)
                            .frame(
                                width: max(50, proxy.size.width * CGFloat(target.box.width) + 8),
                                height: max(50, proxy.size.height * CGFloat(target.box.height) + 8)
                            )
                            .position(
                                x: proxy.size.width * CGFloat(target.box.center.x),
                                y: proxy.size.height * CGFloat(target.box.center.y)
                            )
                    }
                }
            }
            .contentShape(Rectangle())
            .gesture(
                SpatialTapGesture().onEnded { value in
                    guard proxy.size.width > 0, proxy.size.height > 0 else { return }
                    onTap(
                        NormalizedPoint(
                            x: Double(value.location.x / proxy.size.width),
                            y: Double(value.location.y / proxy.size.height)
                        )
                    )
                }
            )
        }
        .aspectRatio(3 / 2, contentMode: .fit)
        .accessibilityLabel(scene.title)
        .accessibilityHint("Listen for an object, then tap it in the picture.")
    }
}

private struct PreciseLocationMarker: View {
    let reducedMovement: Bool
    @State private var pulse = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.yellow, lineWidth: 7)
                .shadow(color: .orange.opacity(0.8), radius: 6)
                .scaleEffect(pulse && !reducedMovement ? 1.06 : 1)

            Image(systemName: "hand.point.up.left.fill")
                .font(.system(size: 34))
                .foregroundStyle(.white, .orange)
                .shadow(color: .black.opacity(0.25), radius: 2, y: 2)
                .offset(x: 18, y: 18)
        }
        .onAppear {
            guard !reducedMovement else { return }
            withAnimation(.easeInOut(duration: 0.65).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}

private struct SuccessMarker: View {
    let reducedMovement: Bool
    @State private var appeared = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.green, lineWidth: 6)
                .shadow(color: .white.opacity(0.9), radius: 4)

            Image(systemName: "sparkles")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.yellow)
                .offset(x: 15, y: -15)
        }
        .scaleEffect(appeared || reducedMovement ? 1 : 0.76)
        .onAppear {
            withAnimation(.spring(response: 0.32, dampingFraction: 0.65)) {
                appeared = true
            }
        }
    }
}

private struct ObjectPreviewOverlay: View {
    let scene: StoryScene
    let target: HiddenTarget

    var body: some View {
        ZStack {
            Color.black.opacity(0.20)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Label("Look for this", systemImage: "eye.fill")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.08, green: 0.28, blue: 0.42))

                CroppedTargetImage(scene: scene, target: target)
                    .frame(width: 300, height: 210)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.yellow, lineWidth: 6)
                    }
            }
            .padding(18)
            .background(.white, in: RoundedRectangle(cornerRadius: 30))
            .shadow(color: .black.opacity(0.28), radius: 24, y: 12)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("A picture of the \(target.label)")
        }
        .allowsHitTesting(true)
    }
}

private struct CroppedTargetImage: View {
    let scene: StoryScene
    let target: HiddenTarget

    var body: some View {
        Group {
            if let croppedImage {
                Image(uiImage: croppedImage)
                    .resizable()
                    .interpolation(.high)
                    .scaledToFit()
            } else {
                Image(scene.imageName, bundle: .module)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }

    private var croppedImage: UIImage? {
        guard
            let source = UIImage(named: scene.imageName, in: .module, compatibleWith: nil),
            let cgImage = source.cgImage
        else {
            return nil
        }

        let preview = target.box.expandedForPreview()
        let bounds = CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height)
        let requested = CGRect(
            x: preview.x * Double(cgImage.width),
            y: preview.y * Double(cgImage.height),
            width: preview.width * Double(cgImage.width),
            height: preview.height * Double(cgImage.height)
        )
        let cropRect = requested.integral.intersection(bounds)

        guard !cropRect.isEmpty, let crop = cgImage.cropping(to: cropRect) else {
            return nil
        }
        return UIImage(cgImage: crop, scale: source.scale, orientation: source.imageOrientation)
    }
}

struct ParentGateView: View {
    @EnvironmentObject private var appState: AppState
    let destination: ParentDestination
    @State private var answer = ""
    @State private var showError = false

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.96, blue: 0.98)
                .ignoresSafeArea()

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

                if showError {
                    Text("Try again, grown-up.")
                        .foregroundStyle(.red)
                }

                HStack(spacing: 16) {
                    Button("Back") { appState.route = .home }
                        .buttonStyle(.bordered)
                    Button("Continue") {
                        if answer.trimmingCharacters(in: .whitespacesAndNewlines) == "12" {
                            appState.route = destination == .dashboard ? .dashboard : .settings
                        } else {
                            showError = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(40)
            .background(.white, in: RoundedRectangle(cornerRadius: 30))
            .shadow(color: .black.opacity(0.12), radius: 16, y: 8)
        }
    }
}

struct ParentDashboardView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var progress: ProgressStore
    @State private var showReset = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if progress.sessions.isEmpty {
                        ContentUnavailableView(
                            "No play yet",
                            systemImage: "chart.bar",
                            description: Text("Play a game and progress will appear here.")
                        )
                    } else {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ],
                            spacing: 12
                        ) {
                            MetricCard(
                                title: "Sessions",
                                value: "\(progress.sessions.count)",
                                detail: timeText(progress.totalSeconds)
                            )
                            MetricCard(
                                title: "Objects",
                                value: "\(progress.totalCompleted)",
                                detail: "completed"
                            )
                            MetricCard(
                                title: "Independent",
                                value: percent(progress.independentRate),
                                detail: "before visual help"
                            )
                            MetricCard(
                                title: "Hints",
                                value: percent(progress.hintRate),
                                detail: "of completed objects"
                            )
                            MetricCard(
                                title: "Attempts",
                                value: decimal(progress.averageAttempts),
                                detail: "average per object"
                            )
                        }

                        Text("Recent sessions")
                            .font(.title3.bold())

                        ForEach(progress.sessions.prefix(8)) { session in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(
                                        session.sceneID
                                            .replacingOccurrences(of: "-", with: " ")
                                            .capitalized
                                    )
                                    .font(.headline)
                                    Text(
                                        session.date.formatted(
                                            date: .abbreviated,
                                            time: .shortened
                                        )
                                    )
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("\(session.completedTargets) found")
                                Text("\(session.hintsUsed) hints")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(14)
                            .background(
                                Color.gray.opacity(0.10),
                                in: RoundedRectangle(cornerRadius: 14)
                            )
                        }
                    }

                    Text("These observations describe play in this app. They are not a diagnosis or developmental assessment.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            .navigationTitle("Parent view")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") { appState.route = .home }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { appState.route = .settings } label: {
                        Image(systemName: "gearshape")
                    }
                    Button(role: .destructive) { showReset = true } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .alert("Reset local progress?", isPresented: $showReset) {
                Button("Reset", role: .destructive) { progress.reset() }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private func percent(_ value: Double?) -> String {
        guard let value else { return "—" }
        return value.formatted(.percent.precision(.fractionLength(0)))
    }

    private func decimal(_ value: Double?) -> String {
        guard let value else { return "—" }
        return value.formatted(.number.precision(.fractionLength(1)))
    }

    private func timeText(_ seconds: Int) -> String {
        seconds < 60 ? "\(seconds)s active" : "\(seconds / 60)m active"
    }
}

private struct MetricCard: View {
    let title: String
    let value: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title.bold())
            Text(detail)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
    }
}

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            Form {
                Section("Play") {
                    Picker("Objects in a picture", selection: $appState.targetLimit) {
                        Text("3 objects").tag(3)
                        Text("4 objects").tag(4)
                        Text("5 objects").tag(5)
                    }
                    Toggle("Show written prompt for co-play", isOn: $appState.promptTextEnabled)
                    Toggle("Reduced movement", isOn: $appState.reducedMovement)
                }

                Section("Privacy") {
                    Text("Progress stays on this iPad. This version does not use a microphone, account, ads, analytics, or an online play service.")
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") { appState.route = .dashboard }
                }
            }
        }
    }
}
