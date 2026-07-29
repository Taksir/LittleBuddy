import AVFoundation
import Foundation

@MainActor
protocol AudioGuidance: AnyObject {
    func speak(_ text: String)
    func stop()
}

@MainActor
final class SystemAudioGuidance: NSObject, AudioGuidance {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.43
        utterance.pitchMultiplier = 1.04
        utterance.volume = 0.9
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
