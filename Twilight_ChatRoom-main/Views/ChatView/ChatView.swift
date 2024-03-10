//
//  ChatView.swift
//  ChatRoom-SwiftUI
//
//  Created by Satvik Viriyala on 30/11/23.
//

import SwiftUI


struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text = ""
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8){
                        ForEach(Array(chatViewModel.messages.enumerated()), id: \.element) { idx, message in
                            MessageView(message: message)
                                .id(idx)
                         }
                        .onChange(of: chatViewModel.messages) { newValue in
                            scrollView.scrollTo(chatViewModel.messages.count - 1, anchor: .bottom)
                        }
                    }
                }
            }
            HStack {
                TextField("Hello There", text: $text, axis: .vertical)
                    .padding()
                    
                ZStack {
                    Button {
                        if text.count > 2 {
                            chatViewModel.sendMessage(text: text) { success in
                                if success {
                                    
                                } else {
                                    print("error sending message")
                                }
                            }
                            text = ""
                        }
                        
                    } label: {
                        Text("send")
                            .padding()
                            .foregroundColor(Color.init(uiColor: .systemBackground))
                            .background(.mint)
                            .cornerRadius(50)
                            .padding(.trailing)
                }
                }
                .padding(.top)
                .shadow(radius: 3)
                
            }.background(Color(uiColor: .systemGray6))
            }
        }
    }


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
