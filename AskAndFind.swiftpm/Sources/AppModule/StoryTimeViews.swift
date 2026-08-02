import SwiftUI
import UIKit

struct ActivityHomeView: View {
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

            ScrollView {
                VStack(spacing: 22) {
                    Text("Ask & Find")
                        .font(.system(size: 54, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .blue.opacity(0.25), radius: 2, y: 2)

                    Text("Listen, look, and learn!")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.35))

                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: 230, maximum: 380), spacing: 18)
                        ],
                        spacing: 18
                    ) {
                        Button { appState.beginGame() } label: {
                            ActivityCard(
                                title: "Find Hidden Objects",
                                subtitle: "Listen, look, and find!",
                                symbol: "sparkle.magnifyingglass",
                                colors: [.white, Color(red: 0.90, green: 0.97, blue: 1.0)]
                            )
                        }
                        .buttonStyle(ActivityCardButtonStyle())

                        Button { appState.route = .storyLibrary } label: {
                            ActivityCard(
                                title: "Story Time",
                                subtitle: "Listen and remember!",
                                symbol: "book.closed.fill",
                                colors: [.white, Color(red: 1.0, green: 0.95, blue: 0.76)]
                            )
                        }
                        .buttonStyle(ActivityCardButtonStyle())

                        Button { appState.route = .storySequencerLibrary } label: {
                            ActivityCard(
                                title: "Story Sequencer",
                                subtitle: "Put the story in order!",
                                symbol: "arrow.triangle.2.circlepath",
                                colors: [.white, Color(red: 0.82, green: 0.94, blue: 0.92)]
                            )
                        }
                        .buttonStyle(ActivityCardButtonStyle())

                        Button { appState.route = .audioRiddles } label: {
                            ActivityCard(
                                title: "Audio Riddles",
                                subtitle: "Who said that?",
                                symbol: "questionmark.bubble.fill",
                                colors: [.white, Color(red: 0.94, green: 0.88, blue: 1.0)]
                            )
                        }
                        .buttonStyle(ActivityCardButtonStyle())
                    }
                    .frame(maxWidth: 860)

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
                    .frame(maxWidth: 820)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 28)
            }
        }
    }
}

private struct ActivityCard: View {
    let title: String
    let subtitle: String
    let symbol: String
    let colors: [Color]

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 66, weight: .bold))
                .foregroundStyle(Color(red: 0.07, green: 0.27, blue: 0.39))
            Text(title)
                .font(.system(size: 27, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(Color(red: 0.07, green: 0.27, blue: 0.39))
        .frame(maxWidth: .infinity)
        .frame(height: 235)
        .background(
            LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom),
            in: RoundedRectangle(cornerRadius: 34)
        )
        .shadow(color: .black.opacity(0.15), radius: 12, y: 7)
    }
}

private struct ActivityCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

struct StoryLibraryView: View {
    @EnvironmentObject private var appState: AppState

    private let books = StoryCatalog.allBooks

    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.97, blue: 0.90)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 18) {
                    HStack {
                        Button { appState.route = .home } label: {
                            Image(systemName: "house.fill")
                                .font(.title2.bold())
                                .frame(width: 64, height: 56)
                        }
                        .buttonStyle(StoryTimeView.ChildControlStyle())

                        Spacer()
                        Text("Story Time")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
                        Spacer()

                        Color.clear.frame(width: 64, height: 56)
                    }
                    .padding(.horizontal, 22)

                    Text("Choose a story to hear")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 18),
                            GridItem(.flexible(), spacing: 18)
                        ],
                        spacing: 18
                    ) {
                        ForEach(books) { book in
                            Button {
                                appState.route = .story(storyID: book.id, sessionToken: UUID())
                            } label: {
                                StoryLibraryCard(book: book)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: 1100)
                    .padding(.horizontal, 22)
                }
                .padding(.vertical, 18)
            }
        }
    }
}

private struct StoryLibraryCard: View {
    let book: StoryBook

    var body: some View {
        VStack(spacing: 10) {
            StoryCoverArtwork(book: book)
                .frame(maxWidth: .infinity)
                .frame(height: 210)
                .clipShape(RoundedRectangle(cornerRadius: 22))

            Text(book.title)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
        }
        .padding(10)
        .background(.white, in: RoundedRectangle(cornerRadius: 28))
        .overlay {
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.9), lineWidth: 3)
        }
        .shadow(color: .black.opacity(0.13), radius: 10, y: 5)
    }
}

struct StoryTimeView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(.accessibilityReduceMotion) private var systemReduceMotion
    @StateObject private var coordinator: StoryTimeCoordinator

    init(book: StoryBook, sessionToken: UUID, progress: StoryProgressStore) {
        _coordinator = StateObject(
            wrappedValue: StoryTimeCoordinator(
                book: book,
                progress: progress,
                sessionToken: sessionToken
            )
        )
    }

    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.97, blue: 0.90)
                .ignoresSafeArea()

            switch coordinator.phase {
            case .cover:
                storyCover
            case .reading:
                storyReader
            case .storyComplete:
                storyComplete
            case .reviewIntro:
                reviewIntro
            case .reviewQuestion, .reviewCorrection, .reviewFeedback:
                storyReview
            case .reviewComplete:
                reviewComplete
            }
        }
        .animation(
            (systemReduceMotion || appState.reducedMovement) ? nil : .easeInOut(duration: 0.25),
            value: coordinator.phase
        )
        .onDisappear { coordinator.stopAndSave() }
    }

    private var storyCover: some View {
        VStack(spacing: 22) {
            topBar(title: "Story Time")

            Spacer(minLength: 8)
            StoryCoverArtwork(book: coordinator.book)
                .frame(maxWidth: 620, maxHeight: 340)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 6)
                }
                .shadow(color: .black.opacity(0.18), radius: 14, y: 8)

            Text(coordinator.book.title)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))

            HStack(spacing: 16) {
                Button("Read") { coordinator.startReading() }
                    .buttonStyle(StoryPrimaryButtonStyle())
                Button("Library") { appState.route = .storyLibrary }
                    .buttonStyle(.bordered)
                    .font(.title3.bold())
            }
            Spacer(minLength: 12)
        }
        .padding(.horizontal, 28)
    }

    private var storyReader: some View {
        Group {
            if let page = coordinator.currentPage {
                VStack(spacing: 8) {
                    topBar(title: coordinator.book.title, showsReplay: true) {
                        coordinator.replayCurrentPage()
                    }

                    StoryPageArtwork(page: page, book: coordinator.book)
                        .frame(maxWidth: 1120)
                        .frame(maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay {
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white, lineWidth: 5)
                        }
                        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 40).onEnded { value in
                                guard abs(value.translation.width) > abs(value.translation.height) else { return }
                                if value.translation.width < 0 {
                                    coordinator.goForward()
                                } else {
                                    coordinator.goBack()
                                }
                            }
                        )

                    VStack(spacing: 8) {
                        Text(page.displayedText)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
                            .frame(maxWidth: 1000)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(.white, in: RoundedRectangle(cornerRadius: 18))

                        HStack(spacing: 18) {
                            Button { coordinator.goBack() } label: {
                                Image(systemName: "arrow.left.circle.fill")
                                    .font(.system(size: 58))
                            }
                            .disabled(!coordinator.canGoBack)

                            StoryPageDots(
                                count: coordinator.book.pages.count,
                                selectedIndex: coordinator.pageIndex
                            )

                            Button { coordinator.goForward() } label: {
                                Image(systemName: coordinator.pageIndex == coordinator.book.pages.count - 1
                                      ? "checkmark.circle.fill"
                                      : "arrow.right.circle.fill")
                                    .font(.system(size: 58))
                            }
                        }
                        .foregroundStyle(Color(red: 0.10, green: 0.32, blue: 0.58))
                        .padding(.bottom, 4)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
            } else {
                malformedStory
            }
        }
    }

    private var storyComplete: some View {
        VStack(spacing: 18) {
            topBar(title: "The End")
            if let page = coordinator.book.pages.last {
                StoryPageArtwork(page: page, book: coordinator.book)
                    .frame(maxWidth: 720, maxHeight: 370)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
            }
            Text("You listened to the whole story.")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
            HStack(spacing: 16) {
                Button("Think About the Story") { coordinator.beginReview() }
                    .buttonStyle(StoryPrimaryButtonStyle())
                Button("Read Again") {
                    coordinator.startAgain()
                }
                .buttonStyle(.bordered)
                Button("Library") { appState.route = .storyLibrary }
                    .buttonStyle(.bordered)
            }
            .font(.title3.bold())
        }
        .padding(24)
    }

    private var reviewIntro: some View {
        VStack(spacing: 20) {
            topBar(title: "Think About the Story")
            if let page = coordinator.book.pages.last {
                StoryPageArtwork(page: page, book: coordinator.book)
                    .frame(maxWidth: 720, maxHeight: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
            }
            Text("Let’s remember what happened.")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
            ProgressView()
                .tint(.orange)
        }
        .padding(24)
    }

    private var storyReview: some View {
        Group {
            if let question = coordinator.currentQuestion {
                let referencedPage = coordinator.book.pages.first { $0.id == question.referencedPageID }

                VStack(spacing: 10) {
                    topBar(title: "Think About the Story", showsReplay: true) {
                        coordinator.replayQuestion()
                    }

                    if let referencedPage {
                        StoryPageArtwork(page: referencedPage, book: coordinator.book)
                            .frame(maxWidth: 920)
                            .frame(maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            .overlay {
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(.white, lineWidth: 5)
                            }
                    }

                    Text(question.prompt)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
                        .frame(maxWidth: 980)

                    if !coordinator.feedback.isEmpty && coordinator.phase != .reviewQuestion {
                        Text(coordinator.feedback)
                            .font(.title3.weight(.semibold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
                            .frame(maxWidth: 980)
                    }

                    HStack(spacing: 18) {
                        ForEach(question.choices) { choice in
                            StoryChoiceCard(
                                choice: choice,
                                isSelected: coordinator.selectedChoiceID == choice.id,
                                isCorrectAnswer: coordinator.correctChoiceID == choice.id,
                                phase: coordinator.phase
                            ) {
                                coordinator.choose(choice)
                            }
                        }
                    }
                    .frame(maxWidth: 900)

                    if coordinator.phase == .reviewFeedback {
                        Button("Continue") { coordinator.continueReview() }
                            .buttonStyle(StoryPrimaryButtonStyle())
                            .padding(.bottom, 4)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            } else {
                malformedStory
            }
        }
    }

    private var reviewComplete: some View {
        VStack(spacing: 22) {
            topBar(title: "Wonderful Listening")
            Image(systemName: "hands.clap.fill")
                .font(.system(size: 82))
                .foregroundStyle(.orange)
            Text("You remembered the story so carefully.")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
            HStack(spacing: 16) {
                Button("Read Again") { coordinator.startAgain() }
                    .buttonStyle(StoryPrimaryButtonStyle())
                Button("Library") { appState.route = .storyLibrary }
                    .buttonStyle(.bordered)
            }
            .font(.title3.bold())
        }
        .padding(24)
    }

    private var malformedStory: some View {
        VStack(spacing: 18) {
            topBar(title: "Story unavailable")
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 72))
                .foregroundStyle(.orange)
            Text("This story is not ready yet.")
                .font(.title.bold())
            Button("Library") { appState.route = .storyLibrary }
                .buttonStyle(StoryPrimaryButtonStyle())
        }
        .padding(24)
    }

    private func topBar(
        title: String,
        showsReplay: Bool = false,
        replay: @escaping () -> Void = {}
    ) -> some View {
        HStack(spacing: 14) {
            Button { appState.route = .storyLibrary } label: {
                Image(systemName: "books.vertical.fill")
                    .font(.title2.bold())
                    .frame(width: 64, height: 56)
            }
            .buttonStyle(ChildControlStyle())

            Spacer()
            Text(title)
                .font(.title2.bold())
                .lineLimit(1)
                .frame(maxWidth: 680)
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .background(.white, in: Capsule())
            Spacer()

            if showsReplay {
                Button(action: replay) {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.title2.bold())
                        .frame(width: 64, height: 56)
                }
                .buttonStyle(ChildControlStyle())
            } else {
                Color.clear.frame(width: 64, height: 56)
            }
        }
    }
}

private struct StoryPageDots: View {
    let count: Int
    let selectedIndex: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(index == selectedIndex ? Color.orange : Color.gray.opacity(0.28))
                    .frame(width: index == selectedIndex ? 24 : 10, height: 8)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Page \(selectedIndex + 1) of \(count)")
    }
}

private struct StoryChoiceCard: View {
    let choice: StoryChoice
    let isSelected: Bool
    let isCorrectAnswer: Bool
    let phase: StoryTimePhase
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: choice.symbol)
                    .font(.system(size: 54, weight: .bold))
                Text(choice.label)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)

                if phase == .reviewFeedback && isCorrectAnswer {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                }
            }
            .foregroundStyle(isCorrectAnswer && phase != .reviewQuestion ? .green : .blue)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 126)
            .padding(.horizontal, 14)
            .background(
                isSelected ? Color.yellow.opacity(0.34) : Color.white,
                in: RoundedRectangle(cornerRadius: 22)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(
                        isCorrectAnswer && phase != .reviewQuestion ? Color.green : Color.white,
                        lineWidth: isCorrectAnswer && phase != .reviewQuestion ? 5 : 3
                    )
            }
            .shadow(color: .black.opacity(0.10), radius: 5, y: 3)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(choice.accessibilityLabel)
        .accessibilityHint("Double tap to choose this answer.")
    }
}

private struct StoryPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(Color.orange, in: Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct StoryCoverArtwork: View {
    let book: StoryBook

    var body: some View {
        Group {
            if let image = StoryArtworkLoader.image(book: book, assetName: book.coverAsset) {
                Image(uiImage: image)
                    .resizable()
                    .interpolation(.high)
                    .scaledToFit()
            } else {
                StoryMissingArtwork(title: book.title)
            }
        }
        .accessibilityLabel("Cover illustration for \(book.title)")
    }
}

struct StoryPageArtwork: View {
    let page: StoryPage
    let book: StoryBook

    var body: some View {
        Group {
            if let image = StoryArtworkLoader.image(book: book, assetName: page.imageAsset) {
                Image(uiImage: image)
                    .resizable()
                    .interpolation(.high)
                    .scaledToFit()
            } else {
                StoryMissingArtwork(title: page.title)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.75, green: 0.90, blue: 0.98))
        .accessibilityLabel(page.altText)
    }
}

private enum StoryArtworkLoader {
    static func image(book: StoryBook, assetName: String) -> UIImage? {
        let resourceDirectory = "Stories/\(book.id)/\(book.assetVersion)"
        for ext in ["png", "jpg", "jpeg"] {
            if let url = Bundle.module.url(
                forResource: assetName,
                withExtension: ext,
                subdirectory: resourceDirectory
            ) {
                return UIImage(contentsOfFile: url.path)
            }
        }
        return nil
    }
}

private struct StoryMissingArtwork: View {
    let title: String

    var body: some View {
        ZStack {
            Color(red: 0.82, green: 0.91, blue: 0.95)
            VStack(spacing: 12) {
                Image(systemName: "photo")
                    .font(.system(size: 48, weight: .bold))
                Text("Illustration unavailable")
                    .font(.headline)
                Text(title)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(Color(red: 0.10, green: 0.24, blue: 0.28))
            .padding()
        }
    }
}

struct StoryParentDashboardView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var progress: ProgressStore
    @EnvironmentObject private var storyProgress: StoryProgressStore
    @State private var showReset = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Story Time")
                        .font(.largeTitle.bold())

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 12
                    ) {
                        StoryMetricCard(title: "Started", value: "\(storyProgress.totalStarted)")
                        StoryMetricCard(title: "Finished", value: "\(storyProgress.totalCompleted)")
                        StoryMetricCard(title: "Reviews", value: "\(storyProgress.totalReviews)")
                        StoryMetricCard(title: "Questions", value: "\(storyProgress.totalQuestions)")
                        StoryMetricCard(title: "Independent", value: percentage(storyProgress.firstTryRate))
                        StoryMetricCard(title: "After help", value: "\(storyProgress.totalCorrected)")
                    }

                    if storyProgress.sessions.isEmpty {
                        ContentUnavailableView(
                            "No stories yet",
                            systemImage: "book.closed",
                            description: Text("Read a story and its listening review to see observations here.")
                        )
                    } else {
                        Text("Recent stories")
                            .font(.title3.bold())
                        ForEach(storyProgress.sessions.prefix(8)) { session in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(StoryCatalog.book(id: session.storyID)?.title ?? "Unknown story")
                                        .font(.headline)
                                    Text(session.startedAt.formatted(date: .abbreviated, time: .shortened))
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text(session.reviewCompleted ? "reviewed" : "in progress")
                                    .foregroundStyle(.secondary)
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
            .alert("Reset all local progress?", isPresented: $showReset) {
                Button("Reset", role: .destructive) {
                    progress.reset()
                    storyProgress.reset()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private func percentage(_ value: Double?) -> String {
        guard let value else { return "—" }
        return value.formatted(.percent.precision(.fractionLength(0)))
    }
}

private struct StoryMetricCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
    }
}
