//
//  SignUp.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-18.
//

import SwiftUI

struct SignUp: View {
    
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var image: UIImage?
    
    @State var showImagePicker = false
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("dark"))
                    .kerning(1.9)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
            }
            
            //Text field for email and password
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
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("********", text: $password)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                
                Divider()
            })
            .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Confirm Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("********", text: $confirmPassword)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 5)
                
                
                Divider()
            })
            .padding(.top, 25)
            
            //Continue button or arrow
            Button(action: {firebaseManager.signUp(email: email, password: password, image: image!)}) {
                
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

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
