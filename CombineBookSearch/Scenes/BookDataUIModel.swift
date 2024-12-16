import Foundation
import SwiftUI

struct BookDataUIModel: Identifiable {
    let id: String
    let title: String
    let authors: [String]
    let description: String
    let thumbnail: URL?
}

