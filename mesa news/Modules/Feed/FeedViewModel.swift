import Foundation
import RxSwift

class FeedViewModel: ObservableObject {
    @Published private(set) var news: [New] = []
    @Published private(set) var highlights: [New] = []
    @Published private(set) var currentPage: Int = 1
    @Published private(set) var totalPages: Int = 0
    @Published var showLoading: Bool = false
    @Published var invalidToken: Bool? = false
    
    private let newsRepository: NewsRepository = NewsRepositoryImpl()
    private var newsDisposable: Disposable?
    private var highlightsDisposable: Disposable?
    
    func loadNews() {
        self.invalidToken = false
        newsDisposable = newsRepository
            .getNews(currentPage: self.currentPage, perPage: nil, publishedAt: nil)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.newsDisposable?.dispose()
                self.news = response.data ?? []
//                    .filter { !$0.highlight }
                self.news = response.data?.filter { !$0.highlight }.sorted(by: {
                    guard let date1 = $0.publishedAt.toDate(), let date2 = $1.publishedAt.toDate() else { return false }
                    return date1 > date2
                }) ?? []
                self.totalPages = response.pagination?.totalPages ?? 0
                print("leu news!!  \(self.news.count)")
            }, onError: { error in
                if let returnedError = error as? RequestError {
                    if returnedError.code ?? 0 == RequestError.invalidToken.code ?? 0 {
                        self.invalidToken = true
                    }
//                    testmesanews@test.com
                }
                self.newsDisposable?.dispose()
                print("error \(error.localizedDescription)")
            })
    }
    
    func loadHighlights() {
        highlightsDisposable = newsRepository
            .getHighlights()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.highlightsDisposable?.dispose()
                self.highlights = response.data ?? []
                print("leu!! \(self.highlights.count)")
            }, onError: { error in
                self.highlightsDisposable?.dispose()
                print("error \(error.localizedDescription)")
            })
    }
    
    func changePage(step: Int) {
        self.showLoading = true
        self.currentPage += step
        if self.currentPage <= self.totalPages {
            newsDisposable = newsRepository
                .getNews(currentPage: currentPage, perPage: 20, publishedAt: nil)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.newsDisposable?.dispose()
                    
                    self.news = response.data?.filter { !$0.highlight }.sorted(by: {
                        guard let date1 = $0.publishedAt.toDate(), let date2 = $1.publishedAt.toDate() else { return false }
                        return date1 > date2
                    }) ?? []
                    self.showLoading = false
                    
                }, onError: { error in
                    self.newsDisposable?.dispose()
                    print("error \(error.localizedDescription)")
                    self.showLoading = false
                })
        }
    }
}
