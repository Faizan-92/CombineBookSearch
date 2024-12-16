import Foundation

struct FetchBooksResponseModel: Codable {
    let items: [BookResponseModel]?
}

struct BookResponseModel: Codable {
    let id: String
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
    let industryIdentifiers: [[String:String]]?
}

struct ImageLinks: Codable {
    let thumbnail: URL?
}

