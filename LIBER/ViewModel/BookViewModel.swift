//
//  BookViewModel.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-05.
//

import SwiftUI

class BookViewModel: ObservableObject {
    
    @Published var book: Book?
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init(){
        fetch()
    }
    
    func fetch(){
        
        isLoading = true
        errorMessage = nil
        
        let service = APIService()
        
        service.fetchBooks(url: url) { [unowned self] result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                switch result{
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error.description)
                case .success(let book):
                    self.book = book
                }
            }
        }
    }
}
