import Foundation

struct New: Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case content
        case author
        case publishedAt = "published_at"
        case highlight
        case url
        case imageUrl = "image_url"
    }
    
    var title: String
    var description: String
    var content: String
    var author: String
    var publishedAt: String
    var highlight: Bool
    var url: String
    var imageUrl: String
    
    var favorite: Bool = false
    
    static func == (lhs: New, rhs: New) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.content == rhs.content && lhs.author == rhs.author && lhs.publishedAt == rhs.publishedAt && lhs.highlight == rhs.highlight && lhs.url == rhs.url && lhs.imageUrl == rhs.imageUrl
    }
}
