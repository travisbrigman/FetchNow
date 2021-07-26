//
//  Provider.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/23/21.
//

import Foundation

class Provider {
    var urlString: String = ""
    
    func getResults(query: String, completed: @escaping (Result<Welcome, ErrorMessage>) -> Void) {
        
        if query.isEmpty {
            urlString = "https://api.seatgeek.com/2/events?client_id=MjI2MjA3NTR8MTYyNjk2MTc5Ny41OTgwMTI"
        } else {
            urlString = "https://api.seatgeek.com/2/events?q=\(query.replacingOccurrences(of: " ", with: "+"))&client_id=MjI2MjA3NTR8MTYyNjk2MTc5Ny41OTgwMTI"
        }
        

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                //2021-07-23T03:30:00
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let results = try decoder.decode(Welcome.self, from: data)
                completed(.success(results))
                
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
        
    }
}

