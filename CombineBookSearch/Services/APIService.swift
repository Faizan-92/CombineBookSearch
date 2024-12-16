import Foundation
import Combine

enum APIService {
    
    static private var baseURL: String {
        get {
            return "https://www.googleapis.com/books/v1/volumes?q="
        }
    }
    
    static func searchBy(title: String) -> some Publisher<FetchBooksResponseModel, Error> {
        guard let titleForSearch = title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            fatalError("Cannot add %20 to search text")
        }

        let params = titleForSearch.appending("+intitle:").appending(titleForSearch).appending("&printType=books&maxResults=40")
        var request = URLRequest(url: (URL(string: baseURL + params))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("hitting api for title \(title)")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: FetchBooksResponseModel.self, decoder: JSONDecoder())
    }
}
