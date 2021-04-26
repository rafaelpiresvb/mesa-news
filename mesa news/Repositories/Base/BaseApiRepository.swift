import Foundation
import Alamofire
import Reachability
import RxReachability

class BaseApiRepository {
    static var manager: SessionManager {
        let manager = SessionManager.default
        manager.adapter = AccessTokenAdapter()
        manager.retrier = Retrier()
        return manager
    }

    // MARK: Internal Classes
    internal class AccessTokenAdapter: RequestAdapter {
        open func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            let token = SessionHelper.shared.authToken ?? ""
            if (urlRequest.url?.absoluteString != Endpoints.signin) && (urlRequest.url?.absoluteString != Endpoints.signup) {
                urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
            }
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return urlRequest
        }
    }

    internal class Retrier: RequestRetrier {
        func should(_ manager: SessionManager, retry request: Alamofire.Request, with error: Error, completion: @escaping RequestRetryCompletion) {
            if NetworkStatus.shared.reachability?.connection == Reachability.Connection.none {
                completion(true, 0.3)
            } else {
                completion(false, 0.0)
            }
        }
    }
}
