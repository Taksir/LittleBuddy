import SwiftUI

extension StoryTimeView {
    struct ChildControlStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundStyle(Color(red: 0.10, green: 0.32, blue: 0.58))
                .background(.white, in: RoundedRectangle(cornerRadius: 18))
                .scaleEffect(configuration.isPressed ? 0.94 : 1)
                .shadow(color: .black.opacity(0.12), radius: 5, y: 3)
        }
    }
}
