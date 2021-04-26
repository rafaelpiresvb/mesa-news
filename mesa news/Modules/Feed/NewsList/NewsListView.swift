import SwiftUI

struct NewsListView: View {
    
    var news: [New]
    
    var body: some View {

        VStack {
            ForEach(news, id: \.self) { new in
                NewViewCell(new: new)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                    .buttonStyle(PlainButtonStyle())
                
                Divider()

            }
        }
//        .listStyle(InsetListStyle())
        .navigationBarHidden(true)
        
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(news: [New]())
    }
}
