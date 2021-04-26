import Foundation

struct PaginationData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
    }
    
    var currentPage: Int?
    var perPage: Int?
    var totalPages: Int?
    var totalItems: Int?
}

class NewsResponse: Codable {
    var pagination: PaginationData?
    var data: [New]?
}
