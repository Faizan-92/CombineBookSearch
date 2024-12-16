import SwiftUI

struct BookListView : View {
    @StateObject private var viewModel = BookListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                BookItemView(displayData: item)
            }
            .searchable(text: $viewModel.searchText)
            .navigationBarTitle(Text("Books Search"))
        }
    }
}

struct BookListView_Previews : PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
