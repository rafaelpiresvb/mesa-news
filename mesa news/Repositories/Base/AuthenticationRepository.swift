import Foundation
import RxSwift

protocol AuthenticationRepository {
    func signin(email: String, password: String) -> Observable<SigninResponse>
    func signup(name: String, email: String, password: String) -> Observable<SigninResponse>
}
