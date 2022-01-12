//
//  LIBERApp.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-18.
//

import SwiftUI
import Firebase

@main
struct LIBERApp: App {
    
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    init() {
        firebaseManager.getCurrentUser()
    }
    
    var body: some Scene {
        WindowGroup {
            switch firebaseManager.navigate {
            case .landing:
                MainHomeView()
            case .home:
                Home()
            }
        }
    }
}
