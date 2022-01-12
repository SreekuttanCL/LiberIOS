//
//  SplashScreen.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-05.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var startAnimation: Bool = false
    @State var circleAnimation: Bool = false
    
    @Binding var endAnimation: Bool
    
    var body: some View {
        ZStack{
            Color("lightred")
            
            Group{
                 //Custom Shape and animation
                SplashShape()
                    .trim(from: 0, to: startAnimation ? 1 : 0)
                    .stroke(Color.white, style:
                                StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                Circle()
                    .fill(.white)
                    .frame(width: 20, height: 20)
                    .scaleEffect(circleAnimation ? 1 : 0)
            }
            .frame(width: 220, height: 130)
            .scaleEffect(endAnimation ? 0.5 : 0.9)
            .offset(x: -40, y: 0)
            //.offset(x: 0, y: endAnimation ? -400 : 0)
        }
        .offset(y: endAnimation ? -(getRect().height * 1.5) : 0)
        .ignoresSafeArea()
        .onAppear{
            
            withAnimation(.interactiveSpring(response: 2, dampingFraction: 1.05, blendDuration: 1.05).delay(0.15)){
                startAnimation.toggle()
            }
            
            withAnimation(.easeIn.delay(2.9)) {
                circleAnimation.toggle()
            }
            
            withAnimation(.easeIn.delay(3.2)) {
                endAnimation.toggle()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen( endAnimation: .constant(false))
    }
}

struct SplashShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            
            let mid = (rect.width/6)
            let height = rect.height
            
            
            //Line L
            path.move(to: CGPoint(x: mid, y: 0))
            path.addLine(to: CGPoint(x: mid, y: height))
            
            path.move(to: CGPoint(x: mid, y: height))
            path.addLine(to: CGPoint(x: mid * 3, y: height))
            
            //Path I
            path.move(to: CGPoint(x: mid * 3, y: height/1.4))
            path.addLine(to: CGPoint(x: mid * 3, y: height))
            
            //Path B first line
            path.move(to: CGPoint(x: mid * 3.6, y: height/2))
            path.addLine(to: CGPoint(x: mid * 3.6, y: height))
            //Path B top line
            path.move(to: CGPoint(x: mid * 3.6, y: height/2))
            path.addLine(to: CGPoint(x: mid * 4.7, y: height/2))
            //path B top curve
            path.move(to: CGPoint(x: mid * 3.6, y: height/2))
            path.addArc(center: CGPoint(x: mid * 4.2, y: height/2), radius: 20, startAngle: .degrees(120), endAngle: .zero, clockwise: true)
            //path B bottom line
            path.move(to: CGPoint(x: mid * 3.6, y: height))
            path.addLine(to: CGPoint(x: mid * 4.7, y: height))
            //path B bottom curve
            path.move(to: CGPoint(x: mid * 3.6, y: height/2))
            path.addArc(center: CGPoint(x: mid * 4.2, y: height/1), radius: 20, startAngle: .degrees(-120), endAngle: .zero, clockwise: false)
            //path E first line
            path.move(to: CGPoint(x: mid * 5.5, y: height/2))
            path.addLine(to: CGPoint(x: mid * 5.5, y: height))
            //path E top line
            path.move(to: CGPoint(x: mid * 5.5, y: height/2))
            path.addLine(to: CGPoint(x: mid * 6.6, y: height/2))
            //path E middle line
            path.move(to: CGPoint(x: mid * 5.5, y: height/1.3))
            path.addLine(to: CGPoint(x: mid * 6.6, y: height/1.3))
            //path E bottom line
            path.move(to: CGPoint(x: mid * 5.5, y: height))
            path.addLine(to: CGPoint(x: mid * 6.6, y: height))
            //path R first line
            path.move(to: CGPoint(x: mid * 7.3, y: height/2))
            path.addLine(to: CGPoint(x: mid * 7.3, y: height))
            //path R top line
            path.move(to: CGPoint(x: mid * 7.3, y: height/2))
            path.addLine(to: CGPoint(x: mid * 8.4, y: height/2))
            //path R top curve
            path.move(to: CGPoint(x: mid * 7.3, y: height/2))
            path.addArc(center: CGPoint(x: mid * 8, y: height/2), radius: 20, startAngle: .degrees(120), endAngle: .zero, clockwise: true)
            //path R slide line
            path.move(to: CGPoint(x: mid * 7.3, y: height/1.4))
            path.addLine(to: CGPoint(x: mid * 8.4, y: height))
        }
    }
}
