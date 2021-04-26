import SwiftUI

struct LoadingView: View {
    
    @State private var loading = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color("mainColor"), lineWidth: 5)
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: loading ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                self.loading = true
            }
            .onDisappear {
                self.loading = false
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
