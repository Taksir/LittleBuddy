import SwiftUI

struct HomeView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.37, green: 0.77, blue: 0.92), Color(red: 0.88, green: 0.96, blue: 0.71)], startPoint: .top, endPoint: .bottom)
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

                Button {
                    appModel.route = .play
                } label: {
                    VStack(spacing: 10) {
                        Text("🔎")
                            .font(.system(size: 78))
                        Text("Find Hidden Objects")
                            .font(.system(size: 29, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(Color(red: 0.07, green: 0.27, blue: 0.39))
                    .frame(width: 390, height: 205)
                    .background(.white.opacity(0.94), in: RoundedRectangle(cornerRadius: 34, style: .continuous))
                    .shadow(color: .black.opacity(0.15), radius: 12, y: 7)
                }
                .accessibilityIdentifier("startHiddenObjects")

                Spacer()

                HStack {
                    Spacer()
                    Button {
                        appModel.openParentArea(.parentDashboard)
                    } label: {
                        Label("For grown-ups", systemImage: "lock.fill")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(.white.opacity(0.82), in: Capsule())
                    }
                    .accessibilityIdentifier("parentArea")
                }
                .padding(28)
            }
            .padding()
        }
    }
}
