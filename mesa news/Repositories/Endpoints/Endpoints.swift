import Foundation

struct Endpoints {
    
    // MARK: Authentication
    static let signin = ApiConstants.apiBaseUrl + "auth/signin/"
    static let signup = ApiConstants.apiBaseUrl + "auth/signup/"
    
    // MARK: News
    static let news = ApiConstants.apiBaseUrl + "news"
    static let highlights = ApiConstants.apiBaseUrl + "news/highlights/"
    
}
