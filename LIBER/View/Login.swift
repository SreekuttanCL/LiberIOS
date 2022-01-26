//
//  Login.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-18.
//

import SwiftUI

struct Login: View {
    
    @ObservedObject var firebaseManager = FirebaseManager.shared
    
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    
    var body: some View {
        VStack{
            
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("dark"))
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
            
            //Forgot password
            Button {
                
            } label: {
                Text("Forgot Password?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            
            //Continue button or arrow
            Button(action: {
                if email.isEmail {
                    firebaseManager.login(email: email, password: password)
                }
                else {
                    self.showAlert.toggle()
                }
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
        .alert(isPresented:$showAlert) {
            Alert(
                title: Text("Please provide a valid Email"),
                message: Text(""),
                primaryButton: .destructive(Text("Ok")) {
                    print("Deleting...")
                },
                secondaryButton: .cancel()
            )
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
