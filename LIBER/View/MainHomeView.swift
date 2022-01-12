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
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    var body: some View {
        NavigationView{
            VStack{
                
                if bookVM.isLoading {
                    LoadingView()
                }
                else if bookVM.errorMessage != nil {
                    ErrorView(bookVM: bookVM)
                }
                else {
                    BookListView(books: bookVM.book)
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
                    Text("LIBER")
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
            }
        }
    }
}

struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
