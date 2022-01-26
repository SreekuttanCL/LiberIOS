//
//  UpdateContactView.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-26.
//

import SwiftUI

struct UpdateContactView: View {
    
    @ObservedObject var contactManager = ContactManager.shared
    @ObservedObject var vm = CoreDataViewModel()
    
    @State var showImagePicker = false
    
    @State var image: UIImage?
    @State var firstName = ""
    @State var lastName = ""
    @State var phoneNumber = ""
    @State var email = ""
    
    var contact: CoreDataViewModel
    
    @Binding var showAddNewContact: Bool
    
    var body: some View {
        VStack{
            Button(action: {showImagePicker.toggle()}) {
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                        .offset(x: -30, y: -20)
                        .shadow(color: Color("lightred").opacity(0.6), radius: 5, x: 0, y: 0)
                }
                else{
                    Image(systemName: "person.fill")
                        .resizable()
                        .padding()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                        .offset(x: -30, y: -20)
                        .shadow(color: Color("lightred").opacity(0.6), radius: 5, x: 0, y: 0)
                }
            }
            
            HStack{
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("FirstName")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    TextField("FirstName", text: $firstName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("dark"))
                        .padding(.top, 5)
                    
                    
                    Divider()
                })
                    .padding(.top, 25)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("LastName")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    TextField("LastName", text: $lastName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("dark"))
                        .padding(.top, 5)
                    
                    
                    Divider()
                })
                    .padding(.top, 25)
            }
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Email")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("example@gmail.com", text: $email)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                
                Divider()
            })
            .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Phone Number")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("1234567891", text: $phoneNumber)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                
                Divider()
            })
            .padding(.top, 25)
            
            //Continue button or arrow
            Button(action: {contactManager.addContactImage(uid: getUID()+email, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, image: image!)
                
                self.showAddNewContact = false
            }) {
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Circle())
                    .shadow(color: Color("lightred").opacity(0.6), radius: 5, x: 0, y: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
        .padding()

    }
}

//struct UpdateContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateContactView(contact: [ContactsEntity], showAddNewContact: .constant(false))
//    }
//}
