import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class AuthenticationRepositoryImpl: AuthenticationRepository {
    func signin(email: String, password: String) -> Observable<SigninResponse> {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        return BaseApiRepository.manager.rx.request(.post, Endpoints.signin, parameters: parameters, encoding: JSONEncoding.default)
            .flatMap({ $0.validateRequest() })
            .map { return try JSONDecoder().decode(SigninResponse.self, from: $0) }
    }

    func signup(name: String, email: String, password: String) -> Observable<SigninResponse> {
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        return BaseApiRepository.manager.rx.request(.post, Endpoints.signup, parameters: parameters, encoding: JSONEncoding.default)
            .flatMap({ $0.validateRequest() })
            .map { return try JSONDecoder().decode(SigninResponse.self, from: $0) }
    }
}
