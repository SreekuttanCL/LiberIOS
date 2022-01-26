//
//  ContactManager.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-26.
//

import SwiftUI
import Firebase
import CoreData

class ContactManager: ObservableObject {
    
    static let shared = ContactManager()
    var vm = CoreDataViewModel()
    
    func addContactImage(uid: String, firstName: String, lastName: String, email: String, phoneNumber: String, image: UIImage) {
        
        let ref = FirebaseAppManager.shared.storage.reference(withPath: getUID()).child("Contacts")
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

                //self.addNewContact(uid: uid, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, imageURL: url.absoluteString)
                DispatchQueue.main.async{
                    self.vm.addContact(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, imageUrl: url.absoluteString)
                }
                
            }
        }
    }
}
