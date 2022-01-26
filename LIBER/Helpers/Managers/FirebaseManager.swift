//
//  FirebaseManager.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-23.
//

import SwiftUI
import Firebase

final class FirebaseManager: ObservableObject{
    
    static let shared = FirebaseManager()
    
    @Published var navigate: Navigate = .landing
    
    func getCurrentUser(){
        if FirebaseAppManager.shared.auth.currentUser != nil {
            navigate = .landing
        }
        else {
            navigate = .home
        }
    }
    
    //Firebase signup with email and password
    func signUp(email: String, password: String, image: UIImage, firstName: String, lastName: String) {
        
        FirebaseAppManager.shared.auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("Sign up error\(error.localizedDescription)")
            }
            else{
                self.storeProfileImage(image: image, email: email, firstName: firstName, lastName: lastName)
                self.navigate = .landing
            }
        }
    }
    
    //Firebase login with email and password
    func login(email: String, password: String){
        
        FirebaseAppManager.shared.auth.signIn(withEmail: email, password: password) {authResult, error in
            
            if let error = error {
                print("Login error\(error.localizedDescription)")
            }
            else{
                print("Login Sucessfull")
                self.navigate = .landing
            }
        }
    }
    
    //storing image to firebase storage and downloading image url
    func storeProfileImage(image: UIImage, email: String, firstName: String, lastName: String){
        
        let ref = FirebaseAppManager.shared.storage.reference(withPath: getUID())
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return}
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print("Storage error\(error.localizedDescription)")
            }
            
            //download image url
            ref.downloadURL { url, error in
                if let error = error {
                    print("Download Image error\(error.localizedDescription)")
                }
                
                print("Image Downloaded\(url?.absoluteString ?? "")")
                guard let url = url else {
                    return
                }

                self.storeProfileImageUrl(profileImageUrl: url, email: email, firstName: firstName, lastName: lastName)
            }
        }
    }
    
    //storing email, uid and profileimageurl in firestore.
    func storeProfileImageUrl(profileImageUrl: URL, email: String, firstName: String, lastName: String) {
        
        let userData = ["email": email, "uid": getUID(), "profileImageUrl": profileImageUrl.absoluteString, "firstName": firstName, "lastName": lastName]
        
        FirebaseAppManager.shared.firestore.collection("users")
            .document(getUID()).setData(userData) { error in
                if let error = error {
                    print("Firestore error\(error.localizedDescription)")
                }

            }
    }
    
    //signing out from firebase and navigate to Home()
    func signOut(){
        do{
            try FirebaseAppManager.shared.auth.signOut()
            self.navigate = .home
        }
        catch{
            print("Unable to SignOut")
        }
    }
}
