//
//  Extensions.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-18.
//

import SwiftUI

//MARK:- View
extension View{
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    //getting safe area
    func getSafeArea()->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

