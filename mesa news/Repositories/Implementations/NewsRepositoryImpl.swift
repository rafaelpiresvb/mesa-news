import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class NewsRepositoryImpl: NewsRepository {
    func getNews(currentPage: Int? = nil, perPage: Int?, publishedAt: String?) -> Observable<NewsResponse> {
        let parameters: [String: Any] = [
            "current_page": currentPage ?? 0,
            "per_page": perPage ?? 20,
            "published_at": publishedAt ?? ""
        ]
        
        return BaseApiRepository.manager.rx.request(.get, Endpoints.news, parameters: parameters, encoding: URLEncoding(destination: .queryString))
            .flatMap({ $0.validateRequest() })
            .map { return try JSONDecoder().decode(NewsResponse.self, from: $0) }
    }
    
    func getHighlights() -> Observable<HighlightsResponse> {
        return BaseApiRepository.manager.rx.request(.get, Endpoints.highlights)
            .flatMap({ $0.validateRequest() })
            .map { return try JSONDecoder().decode(HighlightsResponse.self, from: $0) }
    }
}
