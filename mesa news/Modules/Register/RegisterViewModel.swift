import Foundation
import RxSwift

class RegisterViewModel: ObservableObject {
    
    @Published var registerShowErrorMessage: Bool = false
    @Published var showFeedView: Bool? = false
    @Published var errorMessage: String = ""
    @Published var registerShowLoading: Bool = false
    
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
    private var signupDisposable: Disposable?
    
    func signup(name: String, email: String, password: String, confirmationPassword: String) {
        
        if name.count == 0 || email.count == 0 || password.count == 0 || confirmationPassword.count == 0 {
            self.errorMessage = "Todos os campos são obrigatórios. Favor verificar!"
            self.registerShowErrorMessage = true
            return
        } else if password != confirmationPassword {
            self.errorMessage = "As senhas não conferem. Favor verificar!"
            self.registerShowErrorMessage = true
            return
        }
        self.registerShowErrorMessage = false
        registerShowLoading = true
        signupDisposable = authenticationRepository
            .signup(name: name, email: email, password: password)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.signupDisposable?.dispose()
                SessionHelper.shared.saveAuthToken(response.token)
                self.showFeedView = true
                self.registerShowLoading = false
            }, onError: { error in
                self.signupDisposable?.dispose()
                self.errorMessage = "Ocorreu um problema ao criar a conta. Tente novamente mais tarde."
                self.registerShowErrorMessage = true
                self.registerShowLoading = false
            })
    }
}

