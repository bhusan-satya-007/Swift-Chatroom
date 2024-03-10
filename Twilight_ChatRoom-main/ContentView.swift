//
//  ContentView.swift
//  ChatRoom-SwiftUI
//
//  Created by Satvik Viriyala on 29/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var showSignIn: Bool
    
    init(showSignIn: Bool = true) {
        self.showSignIn = AuthManager.shared.getCurrentUser() == nil
    }
    
    var body: some View {
        if showSignIn {
            SignInView(showSignIn: $showSignIn)
        } else {
            NavigationStack {
                ZStack {
                    ChatView()
                }
                .navigationTitle("Chatroom")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            do {
                                try AuthManager.shared.signOUt()
                                showSignIn = true
                            } catch {
                                print("error signing out")
                            }
                             
                        } label: {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                    
                }
                
            }
        }
        
        
        
        
    }
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
         
        ContentView()
    }
}


    
