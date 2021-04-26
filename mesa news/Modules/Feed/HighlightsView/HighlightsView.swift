import SwiftUI

struct HighlightsView: View {
    
    var highlights: [New]
    
    var body: some View {
        GeometryReader { view in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(highlights, id: \.self) { highlight in

                        VStack {                                ImageWithURL(highlight.imageUrl)
                                .frame(width: view.size.width , height: 200, alignment: .center)
                                .cornerRadius(15.0)

                            Text(highlight.title)
                                .font(.custom("Avenir Black", size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .lineLimit(2)
                                .foregroundColor(Color("secondaryColor"))
                                    
//                                    .padding(.top, 10)
                                    
//                                    .foregroundColor(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
//                                    .background(Color(red: 72.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, opacity: 10.3))
//                                    .foregroundColor(Color("secondaryColor"))
                                    
//                                    .background(Color(""))
                                
//                            }
                            
                            
//                            .cornerRadius(15.0)
//                            }
                        }
                        .frame(width: view.size.width)
//                        .padding(.leading, 10)
//                        .padding(.trailing, 10)

                    }
                }
            }
        }
    }
}

struct HighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        
        HighlightsView(highlights: [New(title: "Title", description: "Description", content: "content", author: "Author", publishedAt: "2020-07-09T17:15:05.000Z", highlight: false, url: "https://www.foxnews.com/health/coronavirus-quarantines-more-than-2-dozen-washington-state-firefighters", imageUrl: "https://cf-images.us-east-1.prod.boltdns.net/v1/static/694940094001/d5e706c1-4a56-4fac-80e3-247bc960fcfc/82581c93-315b-4850-a229-f44ad61e7928/1280x720/match/image.jpg")])
    }
}
