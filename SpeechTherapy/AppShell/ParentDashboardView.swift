import SwiftUI
import SwiftData

struct ParentDashboardView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.modelContext) private var modelContext
    @State private var summary = ParentSummary.empty
    @State private var period: DashboardPeriod = .week
    @State private var showResetConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Picker("Time period", selection: $period) {
                        ForEach(DashboardPeriod.allCases) { period in Text(period.title).tag(period) }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: period) { _, _ in loadSummary() }

                    if summary.sessionCount == 0 {
                        ContentUnavailableView("No play yet", systemImage: "chart.bar", description: Text("After a few games, you’ll see a gentle picture of usage and progress here."))
                    } else {
                        metricGrid
                        recentSessions
                    }

                    Text("These observations describe play in this app. They are not a diagnosis or a developmental assessment.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("Parent view")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") { appModel.route = .home }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        appModel.route = .settings
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    Button(role: .destructive) {
                        showResetConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .alert("Reset local progress?", isPresented: $showResetConfirmation) {
                Button("Reset", role: .destructive) { resetProgress() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This removes session history from this iPad. Bundled pictures are not removed.")
            }
        }
        .task { loadSummary() }
    }

    private var metricGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            MetricCard(title: "Sessions", value: "\(summary.sessionCount)", detail: "\(timeText(summary.activePlaySeconds)) active play")
            MetricCard(title: "Objects", value: "\(summary.targetsCompleted)", detail: "completed")
            MetricCard(title: "First try", value: percentage(summary.firstTryRate), detail: "without a miss")
            MetricCard(title: "Independent", value: percentage(summary.independentSuccessRate), detail: "before visual help")
            MetricCard(title: "Hints", value: percentage(summary.hintRate), detail: "of completed objects")
            MetricCard(title: "Attempts", value: decimal(summary.averageAttempts), detail: "average per object")
        }
    }

    private var recentSessions: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent sessions")
                .font(.title3.bold())
            ForEach(summary.recentSessions) { session in
                HStack {
                    VStack(alignment: .leading) {
                        Text(session.sceneID.replacingOccurrences(of: "-", with: " ").capitalized)
                            .font(.headline)
                        Text(session.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text("\(session.completedTargets) found")
                    Text("\(session.hintsUsed) hints")
                        .foregroundStyle(.secondary)
                }
                .padding(14)
                .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
            }
        }
    }

    private func loadSummary() {
        do {
            let events = try SwiftDataProgressRepository(context: modelContext).allEvents()
            summary = ParentMetricsCalculator.summary(events: events, since: period.startDate)
        } catch {
            summary = .empty
        }
    }

    private func resetProgress() {
        do {
            try SwiftDataProgressRepository(context: modelContext).resetAll()
            loadSummary()
        } catch {
            // The existing dashboard continues to display its prior summary if a local reset fails.
        }
    }

    private func percentage(_ value: Double?) -> String {
        guard let value else { return "—" }
        return value.formatted(.percent.precision(.fractionLength(0)))
    }

    private func decimal(_ value: Double?) -> String {
        guard let value else { return "—" }
        return value.formatted(.number.precision(.fractionLength(1)))
    }

    private func timeText(_ seconds: Int) -> String {
        if seconds < 60 { return "\(seconds)s" }
        return "\(seconds / 60)m"
    }
}

private enum DashboardPeriod: String, CaseIterable, Identifiable {
    case week, month, allTime
    var id: String { rawValue }
    var title: String { self == .week ? "7 days" : (self == .month ? "30 days" : "All time") }
    var startDate: Date {
        switch self {
        case .week: Calendar.current.date(byAdding: .day, value: -7, to: .now) ?? .distantPast
        case .month: Calendar.current.date(byAdding: .day, value: -30, to: .now) ?? .distantPast
        case .allTime: .distantPast
        }
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
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
    }
}
