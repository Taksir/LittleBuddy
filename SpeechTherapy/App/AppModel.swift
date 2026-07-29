import Foundation
import Observation

enum AppRoute {
    case home
    case play
    case parentGate
    case parentDashboard
    case settings
}

@Observable
@MainActor
final class AppModel {
    var route: AppRoute = .home
    var parentGateReturnRoute: AppRoute = .home
    var promptTextEnabled: Bool {
        didSet { UserDefaults.standard.set(promptTextEnabled, forKey: Self.promptTextKey) }
    }
    var reducedStimulation: Bool {
        didSet { UserDefaults.standard.set(reducedStimulation, forKey: Self.reducedStimulationKey) }
    }
    var targetLimit: Int {
        didSet { UserDefaults.standard.set(targetLimit, forKey: Self.targetLimitKey) }
    }

    private static let promptTextKey = "promptTextEnabled"
    private static let reducedStimulationKey = "reducedStimulation"
    private static let targetLimitKey = "targetLimit"

    init() {
        promptTextEnabled = UserDefaults.standard.bool(forKey: Self.promptTextKey)
        reducedStimulation = UserDefaults.standard.bool(forKey: Self.reducedStimulationKey)
        let savedLimit = UserDefaults.standard.integer(forKey: Self.targetLimitKey)
        targetLimit = (3...5).contains(savedLimit) ? savedLimit : 5
    }

    func openParentArea(_ destination: AppRoute) {
        parentGateReturnRoute = destination
        route = .parentGate
    }
}
