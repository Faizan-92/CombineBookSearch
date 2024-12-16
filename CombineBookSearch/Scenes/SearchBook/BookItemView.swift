import SwiftUI

struct BookItemView: View {
    @State private var bookImage: UIImage? = nil
    private let placeholderImge = UIImage(named: "bookPlaceholder")!
    private let displayData: BookDataUIModel
    
    init(displayData: BookDataUIModel) {
        self.displayData = displayData
    }
    
    var body: some View {
        HStack {
            Image(uiImage: bookImage ?? placeholderImge)
                .resizable()
                .frame(width: 50, height: 65)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(displayData.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack {
                    Text("Authors:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    ForEach(displayData.authors, id: \.self) { e in
                        Text(e)
                            .font(.footnote)
                    }
                }
            }
        }
        .frame(height: 65)
    }
}

struct SearchBookCell_Previews : PreviewProvider {
    static let bookDemoData = BookDataUIModel(id: "1234", title: "Demo Book Demo Book Demo Book Demo Book Demo Book", authors: ["Author1","Author2"], description: "BookDescription", thumbnail: URL(string:"bookDemo")!)

    static var previews: some View {
        BookItemView(displayData: bookDemoData)
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("SearchBookCell")
    }
}
