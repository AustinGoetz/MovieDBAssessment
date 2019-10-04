//
//  MovieController.swift
//  MovieDBAssessment
//
//  Created by Austin Goetz on 10/4/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

class MovieController {
    
    // Pass in base URL and set it as baseURL
    let baseURL = URL(string: MovieConstants.baseURL)
    
    func getMovies(with searchTerm: String, completion: @escaping ([Movies]) -> Void) {
        
        guard let url = baseURL else {completion([]); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let keyQueryItem = URLQueryItem(name: MovieConstants.keyQueryItem, value: searchTerm)
        
        components?.queryItems = [keyQueryItem]
        
        guard let finalURL = components?.url else {
            print("Error getting components - query items causing trouble")
            completion([])
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print("Error getting stuff back from Apple. \(error.localizedDescription)")
            }
            
            guard let data = data else {completion([]); return}
            
            do {
                let jsonDecoder = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(jsonDecoder.results)
            } catch {
                completion([])
            }
        }; dataTask.resume()
    }
}
