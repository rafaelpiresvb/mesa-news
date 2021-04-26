import Foundation
import KeychainSwift

class SessionHelper {
    static let shared = SessionHelper()
    fileprivate var userDefaults = UserDefaults.standard
    
    private init() { }
    
    var authToken: String? {
        set {
            saveAuthToken(newValue)
        }
        get {
            return retrieveAuthToken()
        }
    }
}


extension SessionHelper {
    func retrieveAuthToken() -> String? {
        return KeychainSwift().get(Constants.Keychain.authToken)
    }
    
    func saveAuthToken(_ authToken: String?) {
        if let authToken = authToken {
            KeychainSwift().set(authToken, forKey: Constants.Keychain.authToken)
        } else {
            KeychainSwift().delete(Constants.Keychain.authToken)
        }
    }
}
