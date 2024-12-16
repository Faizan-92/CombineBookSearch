import Foundation
import SwiftUI
import Combine

final class BookListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var items = [BookDataUIModel]()
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        // fetchInitialData()
        setupObservers()
    }

    private func setupObservers() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { APIService.searchBy(title: $0).replaceError(with: FetchBooksResponseModel(items: nil)) }
            .switchToLatest()
            .compactMap { [weak self] in
                self?.convertToUIModel(books: $0.items)
            }
            .assign(to: &$items)
//            .sink(receiveValue: { [weak self] items in
//                self?.items = items ?? []
//            })
//            .store(in: &cancellables)
            
    }

//    private func fetchInitialData() {
//        APIService.searchBy(title: "")
//            .replaceError(with: FetchBooksResponseModel(items: nil))
//            .map { self.convertToUIModel(books: $0.items) }
//            .sink(receiveValue: { [weak self] items in
//                self?.items = items
//            })
//            .store(in: &cancellables)
//    }

    private func convertToUIModel(books: [BookResponseModel]?) -> [BookDataUIModel]  {
        var displayDataItems = [BookDataUIModel]()
        
        books?.forEach {
            let displayData = BookDataUIModel(id: $0.id,
                                              title: $0.volumeInfo?.title ?? "",
                                              authors: $0.volumeInfo?.authors ?? [],
                                              description: $0.volumeInfo?.description ?? "",
                                              thumbnail: $0.volumeInfo?.imageLinks?.thumbnail)
            displayDataItems.append(displayData)
        }
        return displayDataItems
    }
}

