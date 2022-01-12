//
//  Constants.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2021-12-23.
//

import SwiftUI
import Firebase

//MARK: -  function to get userid from firebase
internal func getUID() -> String {
    let UserId = Auth.auth().currentUser?.uid
    return UserId ?? "notFound"
}

//MARK: - Google Books API
let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=harry+potter")
