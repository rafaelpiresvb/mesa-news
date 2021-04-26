import SwiftUI

struct FeedView: View {
    
    init() {
        print("FeedView")
    }
    
    @StateObject var viewModel = FeedViewModel()
    @State private var loading = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                
                VStack {
                    
                    VStack {
                        Text("Mesa News")
                            .font(.custom("Avenir Black", size: 24))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("mainColor"))
                            .padding(.leading, 10)
                        
                        Divider()
                    }
                    
                    NavigationLink(
                        destination: LoginView()
                            .navigationTitle("")
                            .navigationBarHidden(true),
                        tag: true,
                        selection: $viewModel.invalidToken) {
                        Text("")
                            .hidden()
                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ScrollViewReader { scroll in
                        
                            VStack {
                                Text("Destaques")
                                    .font(.custom("Avenir Black", size: 20))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                HighlightsView(highlights: viewModel.highlights)
                            }
                            .frame(height: 300)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .id(0)
                            
                            Divider()
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                    
                            VStack {
                                Text("Notícias")
                                    .font(.custom("Avenir Black", size: 20))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                    NewsListView(news: viewModel.news)
                            }
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    
                            HStack {
                                Button(action: {
                                    viewModel.changePage(step: -1)
                                    scroll.scrollTo(0)
                                }, label: {
                                    Text("Anterior")
                                        .font(.custom("Avenir", size: 16))
                                })
                                .foregroundColor(viewModel.currentPage <= 1 ? .gray : Color("mainColor"))
                                .disabled(viewModel.currentPage <= 1)
                                
                                Text("Pagina \(viewModel.currentPage) de \(viewModel.totalPages)")
                                    .font(.custom("Avenir", size: 16))
                                
                                Button(action: {
                                    viewModel.changePage(step: 1)
                                    scroll.scrollTo(0)
                                }, label: {
                                    
                                    Text("Próxima")
                                        .font(.custom("Avenir", size: 16))
                                })
                                .foregroundColor(viewModel.currentPage >= viewModel.totalPages ? .gray : Color("mainColor"))
                                .disabled(viewModel.currentPage >= viewModel.totalPages)
                            
                            }
                        }
                    }
                    
                }
                .blur(radius: viewModel.showLoading ? 3.0 : 0)
                
                if viewModel.showLoading {
                    LoadingView()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.top, 20)
    
        .onAppear {
            self.viewModel.loadHighlights()
            self.viewModel.loadNews()
        }
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
