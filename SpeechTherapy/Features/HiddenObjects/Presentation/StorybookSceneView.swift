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
                SceneBackdrop(theme: scene.theme)

                ForEach(scene.targets) { target in
                    TargetSpriteView(kind: target.kind)
                        .frame(width: proxy.size.width * target.geometry.bbox.width * 1.45, height: proxy.size.height * target.geometry.bbox.height * 1.45)
                        .position(
                            x: proxy.size.width * (target.geometry.bbox.x + target.geometry.bbox.width / 2),
                            y: proxy.size.height * (target.geometry.bbox.y + target.geometry.bbox.height / 2)
                        )
                        .overlay {
                            if target.id == highlightedTargetID {
                                HintMarker(showHand: showHandPointer, reducedMotion: reducedMotion)
                            }
                        }
                        .accessibilityHidden(true)
                }
            }
            .contentShape(Rectangle())
            .gesture(
                SpatialTapGesture().onEnded { value in
                    onTap(NormalizedPoint(x: value.location.x / proxy.size.width, y: value.location.y / proxy.size.height))
                }
            )
        }
        .aspectRatio(4 / 3, contentMode: .fit)
    }
}

private struct HintMarker: View {
    let showHand: Bool
    let reducedMotion: Bool
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.yellow, lineWidth: 7)
                .shadow(color: .orange.opacity(0.7), radius: 7)
                .scaleEffect(pulse && !reducedMotion ? 1.12 : 1)
            if showHand {
                Text("👆")
                    .font(.system(size: 42))
                    .offset(x: 34, y: 38)
            }
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
        switch kind {
        case "bunny": "🐰"; case "hat": "👒"; case "bird": "🐤"; case "apple": "🍎"; case "flower": "🌸"
        case "butterfly": "🦋"; case "ball": "🔵"; case "spoon": "🥄"; case "boat": "⛵"; case "star": "⭐️"
        case "teddy": "🧸"; case "block": "🧱"; case "car": "🚗"; case "book": "📘"; case "drum": "🥁"
        case "kite": "🪁"; case "puzzle": "🧩"; case "crayon": "🖍️"; case "robot": "🤖"; case "balloon": "🎈"
        case "cow": "🐮"; case "tractor": "🚜"; case "egg": "🥚"; case "carrot": "🥕"; case "chicken": "🐔"
        case "boot": "🥾"; case "bucket": "🪣"; case "sunflower": "🌻"; case "duck": "🦆"; case "barn": "🏠"
        case "shell": "🐚"; case "sandcastle": "🏰"; case "crab": "🦀"; case "fish": "🐟"; case "sunglasses": "🕶️"
        case "umbrella": "⛱️"; case "starfish": "🌟"; case "tent": "⛺"; case "lantern": "🏮"; case "backpack": "🎒"
        case "acorn": "🌰"; case "owl": "🦉"; case "mug": "☕️"; case "map": "🗺️"; case "marshmallow": "🍡"
        case "flag": "🚩"; case "cookie": "🍪"; case "cupcake": "🧁"; case "teapot": "🫖"; case "bread": "🍞"
        case "pan": "🍳"; case "banana": "🍌"; case "plate": "🍽️"; case "dinosaur": "🦕"; case "fossil": "🦴"
        case "rocket": "🚀"; case "globe": "🌎"; case "paintbrush": "🖌️"; case "crown": "👑"; case "key": "🔑"
        case "feather": "🪶"; case "snowman": "☃️"; case "scarf": "🧣"; case "sled": "🛷"; case "mitten": "🧤"
        case "penguin": "🐧"; case "snowflake": "❄️"; case "cocoa": "☕️"; case "igloo": "🧊"; case "turtle": "🐢"
        case "seahorse": "🐴"; case "anchor": "⚓️"; case "coral": "🪸"; case "pearl": "⚪️"; case "submarine": "🚤"
        case "basket": "🧺"; case "cheese": "🧀"; case "bus": "🚌"
        default: "✨"
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
            RoundedRectangle(cornerRadius: 42).fill(groundColor.opacity(0.92)).frame(height: 150).offset(y: 175)
            decorativeShapes
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
        case .beach: .yellow; case .reef: .cyan; case .snowyPark: .white; case .playroom, .kitchen, .museum: .orange.opacity(0.25)
        default: .green
        }
    }

    @ViewBuilder private var decorativeShapes: some View {
        if theme == .reef {
            ForEach(0..<7, id: \.self) { index in
                Capsule().fill(.pink.opacity(0.55)).frame(width: 24, height: CGFloat(55 + index * 8)).offset(x: CGFloat(-260 + index * 85), y: 130)
            }
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
