import SwiftUI

struct StorybookSceneView: View {
    let scene: StoryScene
    let currentTarget: HiddenTarget?
    let highlightedTargetID: String?
    let showHandPointer: Bool
    let reducedMotion: Bool
    let onTap: (NormalizedPoint) -> Void

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RuntimeSceneBackdrop(theme: scene.theme)
                ForEach(scene.targets) { target in
                    let box = target.geometry.bbox
                    TargetSpriteView(kind: target.kind)
                        .frame(
                            width: max(46, proxy.size.width * CGFloat(box.width) * 1.45),
                            height: max(46, proxy.size.height * CGFloat(box.height) * 1.45)
                        )
                        .position(
                            x: proxy.size.width * CGFloat(box.x + box.width / 2),
                            y: proxy.size.height * CGFloat(box.y + box.height / 2)
                        )
                        .overlay {
                            if target.id == highlightedTargetID {
                                RuntimeHintMarker(showHand: showHandPointer, reducedMotion: reducedMotion)
                            }
                        }
                        .accessibilityHidden(true)
                }
            }
            .contentShape(Rectangle())
            .gesture(SpatialTapGesture().onEnded { value in
                guard proxy.size.width > 0, proxy.size.height > 0 else { return }
                onTap(NormalizedPoint(x: Double(value.location.x / proxy.size.width), y: Double(value.location.y / proxy.size.height)))
            })
        }
        .aspectRatio(4 / 3, contentMode: .fit)
    }
}

private struct RuntimeHintMarker: View {
    let showHand: Bool
    let reducedMotion: Bool
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.yellow, lineWidth: 7)
                .shadow(color: .orange.opacity(0.7), radius: 7)
                .scaleEffect(pulse && !reducedMotion ? 1.12 : 1)
            if showHand { Text("👆").font(.system(size: 42)).offset(x: 34, y: 38) }
        }
        .onAppear {
            guard !reducedMotion else { return }
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) { pulse = true }
        }
    }
}

private struct TargetSpriteView: View {
    let kind: String

    var body: some View {
        Text(symbol)
            .font(.system(size: 52))
            .minimumScaleFactor(0.45)
            .shadow(color: .black.opacity(0.18), radius: 2, y: 2)
    }

    private var symbol: String {
        let symbols: [String: String] = [
            "bunny": "🐰", "hat": "👒", "bird": "🐤", "apple": "🍎", "flower": "🌸", "butterfly": "🦋", "ball": "🔵", "spoon": "🥄", "boat": "⛵", "star": "⭐️",
            "teddy": "🧸", "block": "🧱", "car": "🚗", "book": "📘", "drum": "🥁", "kite": "🪁", "puzzle": "🧩", "crayon": "🖍️", "robot": "🤖", "balloon": "🎈",
            "cow": "🐮", "tractor": "🚜", "egg": "🥚", "carrot": "🥕", "chicken": "🐔", "boot": "🥾", "bucket": "🪣", "sunflower": "🌻", "duck": "🦆", "barn": "🏠",
            "shell": "🐚", "sandcastle": "🏰", "crab": "🦀", "fish": "🐟", "sunglasses": "🕶️", "umbrella": "⛱️", "starfish": "🌟", "tent": "⛺", "lantern": "🏮", "backpack": "🎒",
            "acorn": "🌰", "owl": "🦉", "mug": "☕️", "map": "🗺️", "marshmallow": "🍡", "flag": "🚩", "cookie": "🍪", "cupcake": "🧁", "teapot": "🫖", "bread": "🍞",
            "pan": "🍳", "banana": "🍌", "plate": "🍽️", "dinosaur": "🦕", "fossil": "🦴", "rocket": "🚀", "globe": "🌎", "paintbrush": "🖌️", "crown": "👑", "key": "🔑", "feather": "🪶",
            "snowman": "☃️", "scarf": "🧣", "sled": "🛷", "mitten": "🧤", "penguin": "🐧", "snowflake": "❄️", "cocoa": "☕️", "igloo": "🧊", "turtle": "🐢", "seahorse": "🐴",
            "anchor": "⚓️", "coral": "🪸", "pearl": "⚪️", "submarine": "🚤", "basket": "🧺", "cheese": "🧀", "bus": "🚌"
        ]
        return symbols[kind, default: "✨"]
    }
}

private struct RuntimeSceneBackdrop: View {
    let theme: SceneTheme

    var body: some View {
        ZStack {
            LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
            Circle().fill(.white.opacity(0.55)).frame(width: 180).offset(x: -260, y: -145)
            Circle().fill(.white.opacity(0.38)).frame(width: 115).offset(x: 270, y: -110)
            RoundedRectangle(cornerRadius: 42).fill(groundColor.opacity(0.92)).frame(height: 150).offset(y: 175)
            if theme == .reef {
                HStack(spacing: 42) {
                    ForEach(0..<6, id: \.self) { index in
                        Capsule().fill(.pink.opacity(0.55)).frame(width: 24, height: CGFloat(54 + index * 9))
                    }
                }.offset(y: 130)
            } else {
                HStack(spacing: 42) {
                    ForEach(0..<5, id: \.self) { _ in Circle().fill(.green.opacity(0.55)).frame(width: 120, height: 120) }
                }.offset(y: -145)
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
