//
//  ContactViewModel.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-26.
//

import SwiftUI

class ContactViewModel: ObservableObject {
    
    @Published var contact: Contact?
    
    init(){
        fetchContact()
    }
    
    private func fetchContact(){
        
        FirebaseAppManager.shared.firestore.collection("users").document("test").getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch user: \(error)")
                return
            }
            
            guard let data = snapshot?.data() else { return}
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? "No Email"
            let ImageUrl = data["ImageUrl"] as? String ?? ""
            let firstName = data["firstName"] as? String ?? ""
            let lastName = data["lastName"] as? String ?? ""
            let phoneNumber = data["phoneNumber"] as? String ?? ""
            
            print("Email:\(email)")
            
            self.contact = Contact(uid: uid, firstName: firstName, lastName: lastName, email: email, imageUrl: ImageUrl, phoneNumber: phoneNumber)
        }
    }
}
