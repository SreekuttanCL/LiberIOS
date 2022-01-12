//
//  Home.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-18.
//

import SwiftUI

struct Home: View {
    
    @State var maxCircleHeight: CGFloat = 0
    
    @State var showSignUp = false
    
    var body: some View {
        
        VStack{
            
            //Top Circle UI
            GeometryReader{proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxCircleHeight == 0{
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                
                    ZStack{
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: getRect().width / 2, y: -height / 1.3)
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: -getRect().width / 2, y: -height / 1.5)
                        Circle()
                            .fill(Color("lightred"))
                            .offset(y: -height / 1.3)
                            .rotationEffect(.init(degrees: -5))
                    }
                )
            }
            .frame(maxHeight: getRect().width)
            
            ZStack{
                if showSignUp{
                    SignUp()
                        .transition(.move(edge: .trailing))
                }
                else {
                    Login()
                        .transition(.move(edge: .trailing))
                }
            }
            .padding(.top, -maxCircleHeight / (getRect().height < 750 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
        
            HStack{
                Text(showSignUp ? "Already Member" : "New Member")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {
                    withAnimation {
                        showSignUp.toggle()
                    }
                }) {
                    Text(showSignUp ? "Sign In" : "Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightred"))
                }
            }
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0)
            
            ,alignment: .bottom
        )
        .background(
            //Bottom Circles
            HStack{
                Circle()
                    .fill(Color("lightred"))
                    .frame(width: 80, height: 80)
                    .offset(x: -30, y: (getRect().height < 750 ? 10 : 0))
                
                Spacer()
                
                Circle()
                    .fill(Color("dark"))
                    .frame(width: 110, height: 110)
                    .offset(x: 40, y: 20)
            }
                .offset(y: getSafeArea().bottom + 30)
            
            ,alignment: .bottom
        )
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
