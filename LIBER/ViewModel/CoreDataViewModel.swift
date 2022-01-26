//
//  CoreDataViewModel.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-26.
//

import Foundation
import CoreData

class CoreDataViewModel:ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [ContactsEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "ContactContainer")
        
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? { 
                fatalError("Unresolved Error: \(error)")
            }
        }
        fetchContacts()
    }
    
    func fetchContacts() {
        let request = NSFetchRequest<ContactsEntity>(entityName: "ContactsEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
            
        }
        catch let error{
            print("Error fetching:\(error)")
        }
    }
    
    func addContact(firstName: String, lastName: String, email: String, phoneNumber: String, imageUrl: String) {
        
        DispatchQueue.main.async {
            let newContact = ContactsEntity(context: self.container.viewContext)
            newContact.id = UUID().uuidString
            newContact.firstName = firstName
            newContact.lastName = lastName
            newContact.email = email
            newContact.phoneNumber = phoneNumber
            newContact.imageUrl = imageUrl
            
            self.save()
        }
        
    }
    
    func updateContact(entity: ContactsEntity){
        let currentname = entity.firstName ?? ""
        let newName = currentname + "!"
        entity.firstName = newName
        
        save()
    }
    
    func delete(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        save()
    }
    
    func save() {
        do {
            try container.viewContext.save()
            fetchContacts()
        }
        catch let error {
            print("Error saving:\(error)")
        }
    }
}
