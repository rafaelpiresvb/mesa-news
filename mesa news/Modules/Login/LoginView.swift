import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                VStack {
                    Text("Mesa News")
                        .font(.custom("Avenir Black", size: 25))
                        .padding()
                
                    TextField("E-mail", text: $email)
                        .font(.custom("Avenir", size: 17))
                        .padding()
                        .background(Color("textFieldBackground"))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)

                    SecureField("Senha", text: $password)
                        .font(.custom("Avenir", size: 17))
                        .padding()
                        .background(Color("textFieldBackground"))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
            
                    NavigationLink(
                        destination: FeedView()
                            .navigationTitle("")
                            .navigationBarHidden(true),
                        tag: true,
                        selection: $viewModel.showFeedView) {
                        Button(action: {
                            self.viewModel.signin(email: email, password: password)
                        }) {
                            Text("Entrar")
                                .font(.custom("Avenir Black", size: 17))
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 50)
                                .background(Color("mainColor"))
                                .cornerRadius(15.0)
                        }
                        .alert(isPresented: $viewModel.showErrorMessage) {
                            Alert(title: Text("Erro"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                        }

                    }
            
                    NavigationLink(destination:
                                    RegisterView()    
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                    ) {
                        Text("Cadastre-se")
                            .font(.custom("Avenir Black", size: 17))
                            .foregroundColor(Color("mainColor"))
                            .padding()
                            .frame(width: 220, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("mainColor"), lineWidth: 1))
                    }
                    .buttonStyle(PlainButtonStyle())
//                    .lin
            
                }.padding()
                .blur(radius: viewModel.showLoading ? 3.0 : 0)
   
                if viewModel.showLoading {
                    LoadingView()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
