import Alamofire
import RxSwift

extension DataRequest {
    func validateRequest() -> Observable<Data> {
        return Observable.create { observer in
            self.responseString(encoding: .utf8, completionHandler: { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let statusCode = dataResponse.response?.statusCode ?? 0
                    if statusCode >= 200 && statusCode < 300 {
                        self.onStatusCodeOk(observer: observer, data: data)
                    } else {
                        self.onStatusCodeBad(observer: observer, data: data)
                    }
                    
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
    
    internal func onStatusCodeOk(observer: AnyObserver<Data>, data: String) {
        if let data = data.data(using: .utf8) {
            observer.onNext(data)
            observer.onCompleted()
        }
    }
    
    internal func onStatusCodeBad(observer: AnyObserver<Data>, data: String) {
        do {
            let json = try data.toDictionary()
            var code = 0
            guard let error = (json["message"] as? String) ?? (json["errors"] as? String) else {
                throw RequestError.invalidError
            }
            if let errorCode = json["code"] as? String {
                if errorCode == "INVALID_TOKEN" {
                    observer.onError(RequestError.invalidToken)
                    return
                } else {
                    code = Int(errorCode) ?? 0
                }
            }
            observer.onError(RequestError.requestError(code: code, error: error))
        } catch let error {
            observer.onError(error)
        }
    }
}
