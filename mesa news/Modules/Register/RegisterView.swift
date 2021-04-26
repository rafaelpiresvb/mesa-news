import SwiftUI

struct RegisterView: View {    
    @StateObject var registerViewModel = RegisterViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var registerName: String = ""
    @State private var registerEmail: String = ""
    @State private var registerPassword: String = ""
    @State private var confirmationPassword: String = ""
    
    var body: some View {
        
            ZStack(alignment: .center) {
                VStack {
                    Text("Cadastre-se")
                        .font(.custom("Avenir Black", size: 25))
                        .padding()
                    
                    TextField("Nome", text: $registerName)
                        .font(.custom("Avenir", size: 17))
                        .padding()
                        .background(Color("textFieldBackground"))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                
                    TextField("E-mail", text: $registerEmail)
                        .font(.custom("Avenir", size: 17))
                        .padding()
                        .background(Color("textFieldBackground"))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)

                    SecureField("Senha", text: $registerPassword)
                        .font(.custom("Avenir", size: 17))
                        .padding()
                        .background(Color("textFieldBackground"))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    SecureField("Confirmação senha", text: $confirmationPassword)
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
                        selection: $registerViewModel.showFeedView) {
                        Button(action: {
                            self.registerViewModel.signup(name: registerName, email: registerEmail, password: registerPassword, confirmationPassword: confirmationPassword)
                        }) {
                            Text("Cadastrar")
                                .font(.custom("Avenir Black", size: 17))
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 50)
                                .background(Color("mainColor"))
                                .cornerRadius(15.0)
                        }
                        .alert(isPresented: $registerViewModel.registerShowErrorMessage) {
                            Alert(title: Text("Erro"), message: Text(registerViewModel.errorMessage), dismissButton: .default(Text("OK")))
                        }

                    }
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Login")
                            .font(.custom("Avenir Black", size: 17))
                            .foregroundColor(Color("mainColor"))
                            .padding()
                            .frame(width: 220, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("mainColor"), lineWidth: 1))
                    }
            
                }.padding()
                .blur(radius: registerViewModel.registerShowLoading ? 3.0 : 0)
   
                if registerViewModel.registerShowLoading {
                    LoadingView()
                }
            }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
