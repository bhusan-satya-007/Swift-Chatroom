import SwiftUI

struct SignInView: View {
    
    @Binding var showSignIn: Bool

    var body: some View {
        
                ZStack {
            // Enlarged Image
            Image("Twilight")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            // Title at the top
            Text("Twilight")
                .font(.system(size: 60, weight: .bold, design: .default))
                .foregroundColor(Color.white)
                .padding()
            
            // Buttons at the bottom
            VStack {
                Spacer() // Pushes buttons to the bottom
                
                VStack(spacing: 20) {
                    Button {
                        print("apple")
                    } label: {
                        Text("Sign in with Apple  ")
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.clear))
                            )
                            .frame(width: 300)
                    }

                    Button {
                        AuthManager.shared.signInWithGoogle { result in
                            switch result {
                            case .success(_):
                                showSignIn = false
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        Text("Sign in with Google")
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.clear))
                            )
                            .frame(width: 300)
                    }
                }
                .padding()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(showSignIn: .constant(true))
    }
}
