//
//  APIService.swift
//  LIBER
//
//  Created by Sreekuttan C L on 2022-01-05.
//

import Foundation

struct APIService {
    
    func fetchBooks(url: URL?, completion: @escaping(Result<Book, APIError>) -> Void){
        
        guard let url =   url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error as? URLError{
                completion(Result.failure(APIError.url(error)))
            }
            else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            }
            else if let data = data {
                //Convert to JSON
                do {
                    let books = try JSONDecoder().decode(Book.self, from: data)
                    completion(Result.success(books))
                }
                catch{
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
