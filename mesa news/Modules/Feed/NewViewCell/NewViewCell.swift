import SwiftUI
import RxSwift

struct NewViewCell: View {
    @State var new: New
    
    @State private var favorite = false
        
    var body: some View {
        VStack {
            VStack {
                ImageWithURL(new.imageUrl)
                    .frame(height: 200)
                    .cornerRadius(15.0)
            }
                
            VStack {
                Text(new.title)
                    .font(.custom("Avenir Black", size: 16))
                    .foregroundColor(Color("secondaryColor"))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                
                Text(new.description)
                    .font(.custom("Avenir", size: 14))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                
                Button(action: {
                    self.like()
                }, label: {
                    Image(systemName: favorite ? "heart.fill" : "heart")
                })
                .foregroundColor(Color("mainColor"))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
        }
        .frame(height: 350)
    }
    
    private func like() {
        print("favorito antes \(new.favorite)")
//        self.new.title = "\(self.cont)"
        
        favorite = !favorite
        new.favorite = true
        
        print("favorito depois \(new.favorite)")
        
    }
}

struct NewViewCell_Previews: PreviewProvider {
    static var previews: some View {
        NewViewCell(new: New(title: "Title", description: "Description", content: "content", author: "Author", publishedAt: "2020-07-09T17:15:05.000Z", highlight: false, url: "https://www.foxnews.com/health/coronavirus-quarantines-more-than-2-dozen-washington-state-firefighters", imageUrl: "https://cf-images.us-east-1.prod.boltdns.net/v1/static/694940094001/d5e706c1-4a56-4fac-80e3-247bc960fcfc/82581c93-315b-4850-a229-f44ad61e7928/1280x720/match/image.jpg"))
    }
}
