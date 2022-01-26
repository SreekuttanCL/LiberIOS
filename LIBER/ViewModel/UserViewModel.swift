//
//  UserViewModel.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-29.
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var user: User?
    
    init(){
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        
        FirebaseAppManager.shared.firestore.collection("users").document(getUID()).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch user: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else { return}
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            let firstName = data["firstName"] as? String ?? ""
            let lastName = data["lastName"] as? String ?? ""
            
            self.user = User(uid: uid, firstName: firstName, lastName: lastName, email: email, profileImageUrl: profileImageUrl)
        }
    }
}
