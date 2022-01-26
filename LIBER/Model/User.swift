//
//  User.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-29.
//

import Foundation
import FirebaseFirestoreSwift

struct User {
    
    let uid,firstName,lastName, email, profileImageUrl: String
}

struct Contact:Hashable {
    
    @DocumentID var uid: String?
    let firstName,lastName, email, imageUrl, phoneNumber: String
}
