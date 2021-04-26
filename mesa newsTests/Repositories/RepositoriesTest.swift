import XCTest
@testable import mesa_news
@testable import RxSwift

class RepositoriesTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
    private let newsRepository: NewsRepository = NewsRepositoryImpl()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignin() {
        print("start testSignin")
        let authExpectation = expectation(description: "Authentication API working")
        authenticationRepository
            .signin(email: "testmesanews@test.com", password: "1234")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { response in
                SessionHelper.shared.authToken = response.token
                XCTAssertNotNil(response.token)
                authExpectation.fulfill()
            }, onError: { error in
                let erro = error as! RequestError
                XCTFail(erro.localizedDescription)
                authExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                    XCTFail("timeout errored: \(error)")
                }
        })
    }
    
    func testSignup() {
        print("start testSignup")
        let authExpectation = expectation(description: "Authentication API working")
        authenticationRepository
            .signup(name: "Test", email: "testmesanews@test.com", password: "1234")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { response in
                SessionHelper.shared.authToken = response.token
                XCTAssertNotNil(response.token)
                authExpectation.fulfill()
            }, onError: { error in
                let erro = error as! RequestError
                XCTFail(erro.localizedDescription)
                authExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                    XCTFail("timeout errored: \(error)")
                }
        })
    }
    
    func testGetNews() {
        print("start testGetNews")
        let authExpectation = expectation(description: "News API working")
        newsRepository
            .getNews(currentPage: 1, perPage: 30, publishedAt: nil)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { response in
                
                XCTAssertNotNil(response)
                authExpectation.fulfill()
            }, onError: { error in
                let erro = error as! RequestError
                XCTFail(erro.localizedDescription)
                authExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                    XCTFail("timeout errored: \(error)")
                }
        })
    }
    
    func testGetHighlights() {
        print("start testGetHighlights")
        let authExpectation = expectation(description: "News API working")
        newsRepository
            .getHighlights()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { response in
                
                XCTAssertNotNil(response)
                authExpectation.fulfill()
            }, onError: { error in
                let erro = error as! RequestError
                XCTFail(erro.localizedDescription)
                authExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                    XCTFail("timeout errored: \(error)")
                }
        })
    }
}
