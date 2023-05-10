//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by Lucas Newlands on 04/05/23.
//

import Foundation
import Combine

final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
}
