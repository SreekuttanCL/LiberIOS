//
//  FirebaseAppManager.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-29.
//

import Foundation
import Firebase

class FirebaseAppManager: NSObject{
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseAppManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}
