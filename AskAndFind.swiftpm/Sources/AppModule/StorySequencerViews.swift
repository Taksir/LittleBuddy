import SwiftUI
import UIKit

// MARK: - Story Sequencer Library View
struct StorySequencerLibraryView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedLevel: Int = 3

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.15, green: 0.45, blue: 0.65),
                    Color(red: 0.35, green: 0.75, blue: 0.70)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header Navigation
                HStack {
                    Button {
                        appState.route = .home
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.35))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.white.opacity(0.9), in: Capsule())
                    }

                    Spacer()

                    Text("Story Sequencer")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundStyle(.white)

                    Spacer()

                    // Level Selector Pill
                    Picker("Level", selection: $selectedLevel) {
                        Text("3 Steps").tag(3)
                        Text("4 Steps").tag(4)
                        Text("5 Steps").tag(5)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                    .background(.white.opacity(0.8), in: RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Text("Pick a story and put the pictures in chronological order!")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.white.opacity(0.95))

                // Grid of Fable Storybooks
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: 220, maximum: 260), spacing: 20)
                        ],
                        spacing: 20
                    ) {
                        ForEach(StoryCatalog.books) { book in
                            Button {
                                appState.route = .storySequencer(
                                    storyID: book.id,
                                    level: selectedLevel,
                                    sessionToken: UUID()
                                )
                            } label: {
                                SequencerBookCard(book: book, level: selectedLevel)
                            }
                            .buttonStyle(SequencerCardButtonStyle())
                        }
                    }
                    .padding(24)
                }
            }
        }
    }
}

// MARK: - Book Card Item
private struct SequencerBookCard: View {
    let book: StoryBook
    let level: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                if let uiImage = loadCoverImage(book: book) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                        .clipped()
                        .cornerRadius(14)
                } else {
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(height: 140)
                        .cornerRadius(14)
                }

                Text("\(level) Steps")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.orange, in: Capsule())
                    .padding(8)
            }

            Text(book.title)
                .font(.headline.weight(.bold))
                .foregroundStyle(Color(red: 0.1, green: 0.2, blue: 0.3))
                .lineLimit(2)

            HStack {
                Label("\(book.pages.count) Pages", systemImage: "photo.stack")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "play.circle.fill")
                    .font(.title2)
                    .foregroundStyle(Color(red: 0.2, green: 0.6, blue: 0.8))
            }
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
    }

    private func loadCoverImage(book: StoryBook) -> UIImage? {
        let resourceDirectory = "Stories/\(book.id)/\(book.assetVersion)"
        for ext in ["png", "jpg", "jpeg"] {
            if let url = Bundle.module.url(
                forResource: book.coverAsset,
                withExtension: ext,
                subdirectory: resourceDirectory
            ) {
                return UIImage(contentsOfFile: url.path)
            }
        }
        return nil
    }
}

private struct SequencerCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Main Story Sequencer Game View
struct StorySequencerView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var engine: StorySequencerEngine

    init(book: StoryBook, level: Int, sessionToken: UUID) {
        _engine = StateObject(
            wrappedValue: StorySequencerEngine(
                book: book,
                level: level,
                sessionToken: sessionToken
            )
        )
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.90, green: 0.96, blue: 0.98),
                    Color(red: 0.82, green: 0.92, blue: 0.96)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                // Top Bar
                HStack {
                    Button {
                        appState.route = .storySequencerLibrary
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                            Text("Library")
                        }
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.35))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.white, in: Capsule())
                        .shadow(radius: 2)
                    }

                    Spacer()

                    VStack(spacing: 2) {
                        Text(engine.book.title)
                            .font(.title2.weight(.black))
                            .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.35))
                        Text("Story Sequencer (\(engine.level) Steps)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button {
                        engine.resetBoard()
                    } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.35))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(.white, in: Capsule())
                            .shadow(radius: 2)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                // Status Banner / Feedback
                Text(engine.feedbackMessage)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(engine.isIncorrectFeedback ? Color.red : Color(red: 0.05, green: 0.3, blue: 0.45))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        engine.isIncorrectFeedback
                        ? Color.red.opacity(0.12)
                        : Color.white.opacity(0.9),
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                    .animation(.default, value: engine.feedbackMessage)

                Spacer(minLength: 4)

                // Target Order Slots Track (First, Next, Then, Last...)
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. Target Sequence Order:")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(Color(red: 0.1, green: 0.25, blue: 0.4))
                        .padding(.horizontal, 24)

                    HStack(spacing: 14) {
                        ForEach(0..<engine.level, id: \.self) { slotIdx in
                            SequenceSlotTile(
                                slotIndex: slotIdx,
                                card: engine.placedSlots[slotIdx],
                                isCompleted: engine.isCompleted,
                                totalSlots: engine.level,
                                book: engine.book,
                                onTap: { engine.tapSlot(slotIdx) },
                                onAudioTap: { card in engine.playNarration(for: card) }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                }

                Spacer(minLength: 8)

                // Shuffled Cards Pool
                VStack(alignment: .leading, spacing: 8) {
                    Text("2. Shuffled Cards (Tap to place):")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(Color(red: 0.1, green: 0.25, blue: 0.4))
                        .padding(.horizontal, 24)

                    HStack(spacing: 14) {
                        if engine.poolCards.isEmpty && !engine.isCompleted {
                            Text("All cards placed! Checking order...")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, minHeight: 120)
                                .background(.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 18))
                                .padding(.horizontal, 24)
                        } else {
                            ForEach(engine.poolCards) { card in
                                SequenceCardTile(
                                    card: card,
                                    isSelected: engine.selectedCard == card,
                                    book: engine.book,
                                    onTap: { engine.tapPoolCard(card) },
                                    onAudioTap: { engine.playNarration(for: card) }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }

                Spacer()

                // Victory Overlay Banner
                if engine.isCompleted {
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text("Great Job! Story Complete!")
                                .font(.title2.weight(.black))
                                .foregroundStyle(Color(red: 0.1, green: 0.4, blue: 0.2))
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }

                        HStack(spacing: 16) {
                            Button {
                                appState.route = .storySequencerLibrary
                            } label: {
                                Text("Choose Another Story")
                                    .font(.headline.weight(.bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(Color.blue, in: Capsule())
                            }

                            Button {
                                engine.resetBoard()
                            } label: {
                                Text("Play Again")
                                    .font(.headline.weight(.bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(Color.green, in: Capsule())
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: 550)
                    .background(.white, in: RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.2), radius: 14, y: 6)
                    .transition(.scale.combined(with: .opacity))
                    .padding(.bottom, 20)
                }
            }
            .padding(.vertical, 12)
        }
    }
}

// MARK: - Sequence Slot Tile
private struct SequenceSlotTile: View {
    let slotIndex: Int
    let card: SequencerCard?
    let isCompleted: Bool
    let totalSlots: Int
    let book: StoryBook
    let onTap: () -> Void
    let onAudioTap: (SequencerCard) -> Void

    private var labelName: String {
        if totalSlots == 3 {
            return ["1. First", "2. Next", "3. Last"][slotIndex]
        } else if totalSlots == 4 {
            return ["1. First", "2. Then", "3. Next", "4. Last"][slotIndex]
        } else {
            return ["1. Step 1", "2. Step 2", "3. Step 3", "4. Step 4", "5. Step 5"][slotIndex]
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            Text(labelName)
                .font(.caption.weight(.bold))
                .foregroundStyle(Color(red: 0.1, green: 0.3, blue: 0.5))

            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(card == nil ? Color.white.opacity(0.7) : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(
                                isCompleted ? Color.green : (card == nil ? Color.blue.opacity(0.3) : Color.blue),
                                style: StrokeStyle(lineWidth: isCompleted ? 4 : 2, dash: card == nil ? [6, 4] : [])
                            )
                    )

                if let card = card {
                    VStack(spacing: 4) {
                        if let uiImage = loadCardImage(card: card, book: book) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 110)
                                .clipped()
                                .cornerRadius(12)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 110)
                        }

                        HStack {
                            Text(card.pageTitle)
                                .font(.caption2.weight(.bold))
                                .lineLimit(1)

                            Spacer()

                            Button {
                                onAudioTap(card)
                            } label: {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.caption2)
                                    .foregroundStyle(.blue)
                            }
                        }
                        .padding(.horizontal, 6)
                        .padding(.bottom, 4)
                    }
                    .padding(4)
                } else {
                    VStack(spacing: 6) {
                        Image(systemName: "plus.square.dashed")
                            .font(.largeTitle)
                            .foregroundStyle(.blue.opacity(0.4))
                        Text("Tap to place")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 145, maxHeight: 155)
            .shadow(color: .black.opacity(card != nil ? 0.1 : 0.03), radius: 6, y: 3)
            .onTapGesture {
                onTap()
            }
        }
    }
}

// MARK: - Sequence Card Tile
private struct SequenceCardTile: View {
    let card: SequencerCard
    let isSelected: Bool
    let book: StoryBook
    let onTap: () -> Void
    let onAudioTap: (SequencerCard) -> Void

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                if let uiImage = loadCardImage(card: card, book: book) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 110)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 110)
                }

                Button {
                    onAudioTap(card)
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.caption)
                        .padding(6)
                        .background(.white.opacity(0.9), in: Circle())
                        .shadow(radius: 2)
                }
                .padding(6)
            }

            Text(card.pageTitle)
                .font(.caption.weight(.bold))
                .foregroundStyle(Color(red: 0.1, green: 0.2, blue: 0.3))
                .lineLimit(1)
                .padding(.horizontal, 4)
                .padding(.bottom, 4)
        }
        .padding(4)
        .frame(maxWidth: .infinity, minHeight: 145, maxHeight: 155)
        .background(.white, in: RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(isSelected ? Color.orange : Color.white, lineWidth: isSelected ? 4 : 0)
        )
        .shadow(color: .black.opacity(0.1), radius: 6, y: 3)
        .scaleEffect(isSelected ? 1.04 : 1.0)
        .animation(.easeOut(duration: 0.15), value: isSelected)
        .onTapGesture {
            onTap()
        }
    }
}

private func loadCardImage(card: SequencerCard, book: StoryBook) -> UIImage? {
    let resourceDirectory = "Stories/\(book.id)/\(book.assetVersion)"
    for ext in ["png", "jpg", "jpeg"] {
        if let url = Bundle.module.url(
            forResource: card.imageAsset,
            withExtension: ext,
            subdirectory: resourceDirectory
        ) {
            return UIImage(contentsOfFile: url.path)
        }
    }
    return nil
}
