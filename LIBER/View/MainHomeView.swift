//
//  MainHomeView.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-29.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainHomeView: View {
    
    @ObservedObject var userVM = UserViewModel()
    @ObservedObject var bookVM = BookViewModel()
    @ObservedObject var contactVM = ContactViewModel()
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @ObservedObject var contactManager = ContactManager.shared
    
    @State var showAddNewContact = false
    @State var updateContactView = false
    @State var isShareSheetShowing = false
    
    @StateObject var vm = CoreDataViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                if bookVM.isLoading {
                    LoadingView()
                }
//                else if bookVM.errorMessage != nil {
//                    ErrorView(bookVM: bookVM)
//                }
                else {
                    //BookListView(books: bookVM.book)
                    //ContactListVIew(contact: vm.savedEntities)
                    List{
                        
                        ForEach(vm.savedEntities) {entity in
                            HStack{
                                WebImage(url: URL(string: entity.imageUrl ?? ""))
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(20)
                                
                                VStack(alignment:.leading){
                                
                                    HStack{
                                        
                                        Text(entity.firstName ?? "UnKnown")
                                            .bold()
                                        Text(entity.lastName ?? "UnKnown")
                                            .bold()
                                    }
                                    
                                    Text(entity.email ?? "UnKnown")
                                        .font(.subheadline)
                                    
                                    Text(entity.phoneNumber ?? "UnKnown")
                                        .font(.subheadline)
                                }
                            }
                            .onTapGesture {
                                //vm.updateContact(entity: entity)
                                //updateContactView.toggle()
                                isShareSheetShowing.toggle()
                                
                                let url = URL(string: "https://apple.com")
                                let av = UIActivityViewController(activityItems: [url!],
                                    applicationActivities: nil)
                                
                                UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                            }
                        }
                        .swipeActions {
                            
                        }
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    AnimatedImage(url: URL(string: userVM.user?.profileImageUrl ?? ""))
                        .resizable()
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        .frame(width: 40, height: 40)
                        .scaledToFit()
                }
                ToolbarItem(placement: .principal) {
                    Text(userVM.user?.firstName ?? "")
                        .bold()
                        .italic()
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        firebaseManager.signOut()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddNewContact.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                    
                }
            }
            .fullScreenCover(isPresented: $showAddNewContact, onDismiss: nil) {
                AddNewContact(showAddNewContact: $showAddNewContact)
            }
            .fullScreenCover(isPresented: $updateContactView, onDismiss: nil) {
                UpdateContactView(contact: vm, showAddNewContact: $updateContactView)
            }
        }
    }
}

struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
