//
//  ChatViewModel.swift
//  ChatRoom-SwiftUI
//
//  Created by Satvik Viriyala on 30/11/23.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    
    var subscribers: Set<AnyCancellable> = []
    
    @Published var mockData = [
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
    
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
        
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
    
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
        
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
    
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
        
        Message(userUid: "12345", text: " The quick brown fox jumps over the lazy dog.", photoURL: "", createdAt: Date()),
        ]
    
    init() {
        DatabaseManager.shared.fetchMessages { [weak self] result in
            switch result {
            case .success(let msgs):
                self?.messages = msgs
            case .failure(let error):
                print(error)
            }
        }
        subscribeToMessagePublisher()
    }
    
    func sendMessage(text:String, completion: @escaping (Bool) -> Void) {
        guard let user = AuthManager.shared.getCurrentUser() else {
            return
        }
        let msg = Message(userUid: user.uid, text: text, photoURL: user.photoURL, createdAt: Date())
        DatabaseManager.shared.sendMessageToDatabase(message:msg) { [weak self] success in
            if success {
                completion(true)
            } else{
                completion(false)
            }
        }
    }
    
    func refresh() {
        self.messages = messages
    }
    
    private func subscribeToMessagePublisher() {
        DatabaseManager.shared.messagesPublisher.receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] messages in
                self?.messages = messages
            }
            .store(in: &subscribers)

    }
}
