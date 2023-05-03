//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Lucas Newlands on 03/05/23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthManager {
    static let shared = AuthManager()
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
            return Auth.auth().createUser(withEmail: email, password: password)
                .map(\.user)
                .eraseToAnyPublisher()
        }
}
