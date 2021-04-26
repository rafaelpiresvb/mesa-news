import Foundation
import RxSwift

class LoginViewModel: ObservableObject {
    
    @Published var showErrorMessage: Bool = false
    @Published var showFeedView: Bool? = false
    @Published var errorMessage: String = ""
    @Published var showLoading: Bool = false
    
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
    private var signinDisposable: Disposable?
    
    func signin(email: String, password: String) {
        if email.count == 0 || password.count == 0 {
            self.errorMessage = "Todos os campos são obrigatórios. Favor verificar!"
            self.showErrorMessage = true
            return
        }
        self.showErrorMessage = false
        showLoading = true
        signinDisposable = authenticationRepository
            .signin(email: email, password: password)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.signinDisposable?.dispose()
                SessionHelper.shared.saveAuthToken(response.token)
                self.showFeedView = true
                self.showLoading = false
            }, onError: { error in
                self.showFeedView = false
                self.showLoading = false
                self.signinDisposable?.dispose()
                self.showErrorMessage = true
                self.errorMessage = "E-mail ou senha inválidas"
                print("error \(error.localizedDescription)")
            })
    }
}
