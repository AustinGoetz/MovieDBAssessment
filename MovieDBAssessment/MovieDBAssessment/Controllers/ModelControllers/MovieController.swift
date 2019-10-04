//
//  MovieController.swift
//  MovieDBAssessment
//
//  Created by Austin Goetz on 10/4/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let shared = MovieController()
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
        print(finalURL)
    }
    
    func getImage(for item: Movies, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLAsString = item.image,
            let url = URL(string: imageURLAsString) else {
                print("Item did not have an image available at URL provided")
                completion(nil)
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error retrieving info from Apple: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Could not retrieve data")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
