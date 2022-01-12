//
//  BookListView.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-05.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct BookListView: View {
    
    let books: Book?
    @State var show = false
    @State var url = ""
    
    var body: some View {
        
        List(books?.items ?? [], id:\.self){ book in
            HStack{
                WebImage(url: URL(string:book.volumeInfo.imageLinks.thumbnail))
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
                
                VStack(alignment:.leading){
                    Text(book.volumeInfo.title)
                        .bold()
                    
                    Text(book.volumeInfo.authors[0])
                }
            }
            .onTapGesture {
                self.url = book.volumeInfo.previewLink
                self.show.toggle()
                
            }
        }
        .sheet(isPresented: self.$show) {
            WebView(url: self.url)
        }
        
    }
}

//Change later
struct WebView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: "http://books.google.ca/books?id=eq9XvgAACAAJ&dq=harry+potter&hl=&cd=1&source=gbs_api")!))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}
