import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.37, green: 0.77, blue: 0.92), Color(red: 0.88, green: 0.96, blue: 0.71)],
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
                    VStack(spacing: 10) {
                        Text("🔎").font(.system(size: 78))
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
        _engine = StateObject(wrappedValue: GameEngine(scene: scene, targetLimit: targetLimit, progress: progress))
    }

    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.97, blue: 0.88).ignoresSafeArea()
            VStack(spacing: 12) {
                gameHeader
                StorybookSceneView(
                    scene: engine.scene,
                    highlightedTargetID: engine.highlightedTargetID,
                    showHand: engine.phase == .showingHint || engine.phase == .demonstrating,
                    reducedMovement: systemReduceMotion || appState.reducedMovement,
                    onTap: engine.handleTap
                )
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay(RoundedRectangle(cornerRadius: 28).stroke(.white, lineWidth: 5))
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
        }
        .onAppear { engine.start() }
        .onDisappear { engine.stopAndSave() }
    }

    private var gameHeader: some View {
        HStack(spacing: 16) {
            Button { appState.route = .home } label: {
                Image(systemName: "house.fill").font(.title2.bold()).frame(width: 64, height: 56)
            }
            .buttonStyle(ChildControlStyle())
            Spacer()
            VStack(spacing: 2) {
                if appState.promptTextEnabled, let target = engine.currentTarget {
                    Text(target.question).font(.title2.bold()).lineLimit(1)
                } else {
                    Text("Listen carefully").font(.title2.bold())
                }
                Text(engine.progressText).font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
            }
            .frame(maxWidth: 520)
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(.white, in: Capsule())
            Spacer()
            Button { engine.replay() } label: {
                Image(systemName: "speaker.wave.2.fill").font(.title2.bold()).frame(width: 64, height: 56)
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
    let showHand: Bool
    let reducedMovement: Bool
    let onTap: (NormalizedPoint) -> Void

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                SceneBackdrop(theme: scene.theme)
                ForEach(scene.targets) { target in
                    Text(target.symbol)
                        .font(.system(size: 52))
                        .minimumScaleFactor(0.45)
                        .shadow(color: .black.opacity(0.18), radius: 2, y: 2)
                        .frame(
                            width: max(46, proxy.size.width * CGFloat(target.box.width) * 1.45),
                            height: max(46, proxy.size.height * CGFloat(target.box.height) * 1.45)
                        )
                        .position(
                            x: proxy.size.width * CGFloat(target.box.x + target.box.width / 2),
                            y: proxy.size.height * CGFloat(target.box.y + target.box.height / 2)
                        )
                        .overlay {
                            if target.id == highlightedTargetID {
                                HintMarker(showHand: showHand, reducedMovement: reducedMovement)
                            }
                        }
                        .accessibilityHidden(true)
                }
            }
            .contentShape(Rectangle())
            .gesture(SpatialTapGesture().onEnded { value in
                guard proxy.size.width > 0, proxy.size.height > 0 else { return }
                onTap(NormalizedPoint(
                    x: Double(value.location.x / proxy.size.width),
                    y: Double(value.location.y / proxy.size.height)
                ))
            })
        }
        .aspectRatio(4 / 3, contentMode: .fit)
    }
}

private struct HintMarker: View {
    let showHand: Bool
    let reducedMovement: Bool
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.yellow, lineWidth: 7)
                .shadow(color: .orange.opacity(0.7), radius: 7)
                .scaleEffect(pulse && !reducedMovement ? 1.12 : 1)
            if showHand { Text("👆").font(.system(size: 42)).offset(x: 34, y: 38) }
        }
        .onAppear {
            guard !reducedMovement else { return }
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) { pulse = true }
        }
    }
}

private struct SceneBackdrop: View {
    let theme: SceneTheme

    var body: some View {
        ZStack {
            LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
            Circle().fill(.white.opacity(0.55)).frame(width: 180).offset(x: -260, y: -145)
            Circle().fill(.white.opacity(0.38)).frame(width: 115).offset(x: 270, y: -110)
            RoundedRectangle(cornerRadius: 42)
                .fill(groundColor.opacity(0.92))
                .frame(height: 150)
                .offset(y: 175)
            if theme == .reef {
                HStack(spacing: 42) {
                    ForEach(0..<6, id: \.self) { index in
                        Capsule().fill(.pink.opacity(0.55)).frame(width: 24, height: CGFloat(54 + index * 9))
                    }
                }
                .offset(y: 130)
            } else {
                HStack(spacing: 42) {
                    ForEach(0..<5, id: \.self) { _ in
                        Circle().fill(.green.opacity(0.55)).frame(width: 120, height: 120)
                    }
                }
                .offset(y: -145)
            }
        }
    }

    private var colors: [Color] {
        switch theme {
        case .garden: [.cyan.opacity(0.75), .green.opacity(0.55)]
        case .playroom: [.orange.opacity(0.38), .pink.opacity(0.38)]
        case .farm: [.blue.opacity(0.55), .green.opacity(0.68)]
        case .beach: [.cyan.opacity(0.7), .yellow.opacity(0.65)]
        case .campsite: [.indigo.opacity(0.72), .green.opacity(0.48)]
        case .kitchen: [.yellow.opacity(0.55), .orange.opacity(0.42)]
        case .museum: [.purple.opacity(0.55), .teal.opacity(0.45)]
        case .snowyPark: [.blue.opacity(0.48), .white]
        case .reef: [.blue.opacity(0.82), .teal.opacity(0.68)]
        case .market: [.orange.opacity(0.52), .green.opacity(0.48)]
        }
    }

    private var groundColor: Color {
        switch theme {
        case .beach: .yellow
        case .reef: .cyan
        case .snowyPark: .white
        case .playroom, .kitchen, .museum: .orange.opacity(0.25)
        default: .green
        }
    }
}

struct ParentGateView: View {
    @EnvironmentObject private var appState: AppState
    let destination: ParentDestination
    @State private var answer = ""
    @State private var showError = false

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.96, blue: 0.98).ignoresSafeArea()
            VStack(spacing: 22) {
                Image(systemName: "lock.shield.fill").font(.system(size: 58)).foregroundStyle(.blue)
                Text("Grown-up check").font(.largeTitle.bold())
                Text("What is seven plus five?").font(.title2.weight(.medium))
                TextField("Answer", text: $answer)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 180)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                if showError { Text("Try again, grown-up.").foregroundStyle(.red) }
                HStack(spacing: 16) {
                    Button("Back") { appState.route = .home }.buttonStyle(.bordered)
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
                        ContentUnavailableView("No play yet", systemImage: "chart.bar", description: Text("Play a game and progress will appear here."))
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            MetricCard(title: "Sessions", value: "\(progress.sessions.count)", detail: timeText(progress.totalSeconds))
                            MetricCard(title: "Objects", value: "\(progress.totalCompleted)", detail: "completed")
                            MetricCard(title: "Independent", value: percent(progress.independentRate), detail: "before visual help")
                            MetricCard(title: "Hints", value: percent(progress.hintRate), detail: "of completed objects")
                            MetricCard(title: "Attempts", value: decimal(progress.averageAttempts), detail: "average per object")
                        }
                        Text("Recent sessions").font(.title3.bold())
                        ForEach(progress.sessions.prefix(8)) { session in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(session.sceneID.replacingOccurrences(of: "-", with: " ").capitalized).font(.headline)
                                    Text(session.date.formatted(date: .abbreviated, time: .shortened)).font(.subheadline).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("\(session.completedTargets) found")
                                Text("\(session.hintsUsed) hints").foregroundStyle(.secondary)
                            }
                            .padding(14)
                            .background(Color.gray.opacity(0.10), in: RoundedRectangle(cornerRadius: 14))
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
                ToolbarItem(placement: .topBarLeading) { Button("Done") { appState.route = .home } }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { appState.route = .settings } label: { Image(systemName: "gearshape") }
                    Button(role: .destructive) { showReset = true } label: { Image(systemName: "trash") }
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
            Text(title).font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
            Text(value).font(.title.bold())
            Text(detail).font(.caption).foregroundStyle(.secondary)
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
                ToolbarItem(placement: .topBarLeading) { Button("Back") { appState.route = .dashboard } }
            }
        }
    }
}
