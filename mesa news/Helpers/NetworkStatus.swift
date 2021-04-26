import Foundation
import Reachability

class NetworkStatus {
    static let shared = NetworkStatus()
    let reachability = Reachability()

    init() {
        try? reachability?.startNotifier()
    }
}
