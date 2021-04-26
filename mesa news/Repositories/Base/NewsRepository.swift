import Foundation
import RxSwift

protocol NewsRepository {
    func getNews(currentPage: Int?, perPage: Int?, publishedAt: String?) -> Observable<NewsResponse>
    func getHighlights() -> Observable<HighlightsResponse>
}
