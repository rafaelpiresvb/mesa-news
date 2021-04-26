import Foundation

enum RequestError: LocalizedError {
    case requestError(code: Int, error: String), invalidError, invalidToken
    
    var code: Int? {
        switch self {
        case .requestError(let code, _):
            return code
        default:
            return 0
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .requestError( _, let error):
            return error
        case .invalidToken:
            return "Usuário não autenticado"
        case .invalidError:
            return "Ocorreu algum problema no servidor"
        }
    }
}
