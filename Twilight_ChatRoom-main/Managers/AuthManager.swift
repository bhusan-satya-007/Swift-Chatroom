//
//  AuthManager.swift
//  ChatRoom-SwiftUI
//
//  Created by Satvik Viriyala on 30/11/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct ChatRoomUser {
    let uid: String
    let name: String
    let email: String?
    let photoURL: String?
}

enum GoogleSignInError: Error {
    case unableToGrabTopVC
    case signInPresntationError
    case authSignInError
}

final class AuthManager{
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    func getCurrentUser() -> ChatRoomUser? {
        guard let authUser = auth.currentUser else {
            return nil
        }
        
        return ChatRoomUser(uid: authUser.uid, name: authUser.displayName ?? "Unknown", email: authUser.email, photoURL: authUser.photoURL?.absoluteString )
        }
    
    
    func signInWithGoogle(completion: @escaping (Result<ChatRoomUser, GoogleSignInError>)-> Void) {
        let clientID = "549971641071-db43s4kpgvqgikrh9s52t3pvvb848ahp.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let topVC = UIApplication.getTopViewController() else {
            completion(.failure(.unableToGrabTopVC))
            return
        }
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { [unowned self] result, error in
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString,
                  error == nil
            else {
                completion(.failure(.signInPresntationError))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            auth.signIn(with: credential) { result, error in
                guard let result = result, error == nil else {
                    completion(.failure(.authSignInError))
                    return
                }
                let user = ChatRoomUser(uid: result.user.uid, name: result.user.displayName ?? "UnKnown" , email: result.user.email, photoURL: result.user.photoURL?.absoluteString)
                completion(.success(user))
                
            }
        }
    }
    func signOUt() throws {
        try auth.signOut()
        
    }
}

// MARK: UIApplication extensions

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
