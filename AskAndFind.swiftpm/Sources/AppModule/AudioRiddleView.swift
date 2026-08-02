import SwiftUI
import UIKit

struct AudioRiddleView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var engine = AudioRiddleEngine()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.28, green: 0.18, blue: 0.45),
                    Color(red: 0.52, green: 0.28, blue: 0.65)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                // Top Header Bar
                HStack {
                    Button {
                        engine.stopSpeech()
                        appState.route = .home
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color(red: 0.25, green: 0.1, blue: 0.4))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .frame(minWidth: 80, minHeight: 60)
                        .background(.white, in: Capsule())
                        .shadow(radius: 2)
                    }
                    .accessibilityLabel("Go to Home")
                    .accessibilityHint("Navigates back to the main activity menu.")

                    Spacer()

                    VStack(spacing: 2) {
                        Text("Who Said That? 🔍")
                            .font(.title2.weight(.black))
                            .foregroundStyle(.white)
                        Text("Riddle \(engine.currentRiddleIndex + 1) of \(engine.riddles.count)")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.white.opacity(0.8))
                    }

                    Spacer()

                    // Star Score Counter
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(engine.score)")
                            .font(.title3.weight(.black))
                            .foregroundStyle(Color(red: 0.25, green: 0.1, blue: 0.4))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .frame(minHeight: 60)
                    .background(.white, in: Capsule())
                    .shadow(radius: 2)
                    .accessibilityLabel("\(engine.score) stars earned")
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                // Main Audio Clue Card
                VStack(spacing: 12) {
                    HStack(spacing: 14) {
                        Button {
                            engine.playAudioPrompt()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 60, height: 60)
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                            .shadow(color: .orange.opacity(0.4), radius: 6, y: 3)
                        }
                        .accessibilityLabel("Replay riddle audio clue")
                        .accessibilityHint("Plays the spoken clue for the current riddle.")

                        VStack(alignment: .leading, spacing: 4) {
                            Text(engine.currentRiddle?.prompt ?? "Who am I?")
                                .font(.caption.weight(.black))
                                .foregroundStyle(Color.orange)
                                .textCase(.uppercase)

                            Text(engine.feedbackMessage)
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(
                                    engine.isIncorrectFeedback
                                    ? Color(red: 0.75, green: 0.15, blue: 0.15)
                                    : (engine.isCorrectFeedback ? Color(red: 0.1, green: 0.5, blue: 0.2) : Color(red: 0.1, green: 0.2, blue: 0.35))
                                )
                                .lineLimit(3)
                        }

                        Spacer()
                    }
                }
                .padding(16)
                .frame(maxWidth: 860)
                .background(.white, in: RoundedRectangle(cornerRadius: 24))
                .shadow(color: .black.opacity(0.18), radius: 10, y: 5)
                .padding(.horizontal, 24)

                Spacer(minLength: 4)

                // 2x2 Choice Grid using Buttons
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 18),
                        GridItem(.flexible(), spacing: 18)
                    ],
                    spacing: 18
                ) {
                    ForEach(engine.currentOptions) { option in
                        Button {
                            engine.tapOption(option)
                        } label: {
                            RiddleOptionCard(
                                option: option,
                                isSelected: engine.selectedOptionID == option.id,
                                isCorrect: engine.isCorrectFeedback && option.isCorrect,
                                isIncorrect: engine.isIncorrectFeedback && engine.selectedOptionID == option.id
                            )
                        }
                        .buttonStyle(RiddleButtonStyle())
                        .accessibilityLabel("Option: \(option.title)")
                        .accessibilityHint("Tap to select this picture as the answer.")
                    }
                }
                .frame(maxWidth: 860)
                .padding(.horizontal, 24)

                Spacer(minLength: 4)

                // Next Question Button (when correct)
                if engine.isCorrectFeedback {
                    Button {
                        engine.nextRiddle()
                    } label: {
                        HStack(spacing: 8) {
                            Text("Next Riddle")
                                .font(.title3.weight(.black))
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title2)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 14)
                        .frame(minHeight: 60)
                        .background(Color.green, in: Capsule())
                        .shadow(color: .green.opacity(0.4), radius: 8, y: 4)
                    }
                    .transition(.scale.combined(with: .opacity))
                    .accessibilityLabel("Next Riddle")
                }

                Spacer()
            }
            .padding(.vertical, 12)
            .onDisappear {
                engine.stopSpeech()
            }

            // Victory Session Modal
            if engine.isCompleted {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()

                    VStack(spacing: 16) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 64))
                            .foregroundStyle(.yellow)
                            .shadow(radius: 4)

                        Text("Riddle Master!")
                            .font(.system(size: 36, weight: .black, design: .rounded))
                            .foregroundStyle(Color(red: 0.2, green: 0.1, blue: 0.4))

                        Text("You answered \(engine.score) riddles correctly and earned \(engine.score) stars! 🌟")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)

                        HStack(spacing: 16) {
                            Button {
                                engine.stopSpeech()
                                appState.route = .home
                            } label: {
                                Text("Home")
                                    .font(.headline.weight(.bold))
                                    .foregroundStyle(Color(red: 0.2, green: 0.1, blue: 0.4))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .frame(minHeight: 60)
                                    .background(Color.gray.opacity(0.15), in: Capsule())
                            }

                            Button {
                                engine.startNewSession()
                            } label: {
                                Text("Play Again")
                                    .font(.headline.weight(.bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 28)
                                    .padding(.vertical, 12)
                                    .frame(minHeight: 60)
                                    .background(Color.purple, in: Capsule())
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(28)
                    .frame(maxWidth: 480)
                    .background(.white, in: RoundedRectangle(cornerRadius: 28))
                    .shadow(radius: 20)
                }
            }
        }
    }
}

private struct RiddleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Riddle Option Choice Card
private struct RiddleOptionCard: View {
    let option: AudioRiddleOption
    let isSelected: Bool
    let isCorrect: Bool
    let isIncorrect: Bool

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .topTrailing) {
                if let uiImage = loadOptionImage(option: option) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 125)
                        .clipped()
                        .cornerRadius(16)
                } else {
                    Rectangle()
                        .fill(Color.purple.opacity(0.15))
                        .frame(height: 125)
                        .cornerRadius(16)
                }

                if isCorrect {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title)
                        .foregroundStyle(.green)
                        .padding(8)
                        .background(.white, in: Circle())
                        .shadow(radius: 3)
                } else if isIncorrect {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title2)
                        .foregroundStyle(.orange)
                        .padding(8)
                        .background(.white, in: Circle())
                        .shadow(radius: 3)
                }
            }

            Text(option.title)
                .font(.headline.weight(.bold))
                .foregroundStyle(Color(red: 0.1, green: 0.2, blue: 0.35))
                .lineLimit(1)
                .padding(.horizontal, 6)
                .padding(.bottom, 6)
        }
        .padding(6)
        .frame(minHeight: 160)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    isCorrect ? Color.green : (isIncorrect ? Color.orange : (isSelected ? Color.purple : Color.white)),
                    lineWidth: (isCorrect || isIncorrect || isSelected) ? 4 : 0
                )
        )
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
    }

    private func loadOptionImage(option: AudioRiddleOption) -> UIImage? {
        let resourceDirectory = "Stories/\(option.storyID)/\(option.assetVersion)"
        for ext in ["png", "jpg", "jpeg"] {
            if let url = Bundle.module.url(
                forResource: option.imageAsset,
                withExtension: ext,
                subdirectory: resourceDirectory
            ) {
                return UIImage(contentsOfFile: url.path)
            }
        }
        return nil
    }
}
