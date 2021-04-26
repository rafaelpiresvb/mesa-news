import Foundation

enum ConversionError: Error {
    case couldNotCreateData, couldNotCastToDictionary
}

extension String {
    func toDictionary() throws -> [String: Any] {
        guard let data = data(using: .utf8) else {
            throw ConversionError.couldNotCreateData
        }
        guard let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw ConversionError.couldNotCastToDictionary
        }
        return result
    }
    
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func toDate() -> Date? {
        if let date = DateFormatter.iso8601Full.date(from: self) {
            return date
        } else if let date = ISO8601DateFormatter().date(from: self) {
            return date
        }
        return nil
    }
}
