//
//  MovieTableViewCell.swift
//  MovieDBAssessment
//
//  Created by Austin Goetz on 10/4/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var returnedMovie: Movies? {
        
        didSet {
            guard let movie = returnedMovie else {return}
            
            movieTitleLabel.text = movie.title
            movieRatingLabel.text = "\(movie.rating)"
            movieOverviewLabel.text = movie.overview
            
            
            MovieController.getImage(item: movie) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.movieImageView.image = image
                    }
                } else {
                    print("Image was nil")
                }
            }
        }
    }
}
