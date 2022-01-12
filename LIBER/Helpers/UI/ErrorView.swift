//
//  ErrorView.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-05.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var bookVM: BookViewModel
    
    var body: some View {
        Text("Error")
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(bookVM: BookViewModel())
    }
}
