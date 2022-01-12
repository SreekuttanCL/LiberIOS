//
//  APIError.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-05.
//

import Foundation

enum APIError: Error{
    
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        //feedback for user
        switch self{
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, Connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
    
    var description: String{
        //debugging info
        switch self{
        case .unknown:
            return "Unknown Error."
        case .badURL:
            return "Invalid URL"
        case .badResponse(statusCode: let statusCode):
            return "Bad response with status code\(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "Parsing error \(error?.localizedDescription ?? "")"
        }
    }
}
