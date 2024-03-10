//
//  MessageView.swift
//  ChatRoom-SwiftUI
//
//  Created by Satvik Viriyala on 30/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageView: View {
    var message: Message
    
    
    var body: some View {
        if message.isFromCurrentUser(){
            HStack {
                
                HStack{
                    Text(message.text)
                        .padding()
                        .foregroundColor(Color.init(uiColor: .systemBackground))
                        .background(.mint)
                        .cornerRadius(20)
                    
                }
                .frame(maxWidth: 260, alignment: .trailing)
                
                if let photoURL = message.fetchPhotoURL() {
                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.leading, 4)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.leading, 4)
                    }
                    
                }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
        }
        else {
            HStack {
                if let photoURL = message.fetchPhotoURL() {
                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.leading, 4)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                        .padding(.leading, 4)
                    }
                HStack{
                    Text(message.text)
                        .padding()
                        .background(Color(uiColor: .systemGray5))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 260, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
        }
        }
    }
        


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(userUid: "123", text: "Hello this is a message from me fdjg klj kljdsfgkl gkld jgkj fkgjkj gklf jkljgklj", photoURL: "", createdAt: Date()))
    }
}

