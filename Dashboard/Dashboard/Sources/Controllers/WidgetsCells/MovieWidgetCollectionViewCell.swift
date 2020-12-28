//
//  MovieWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 15/12/2020.
//

import UIKit

class MovieWidgetCollectionViewCell: WidgetCollectionViewCell {
    static let widgetIdentifier = "MovieWidgetCell"
    @IBOutlet var movieLabel: UILabel!
    private let movieRequest = MovieRequest()
    
    static func widgetNib() -> UINib {
        return UINib(nibName: "MovieWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .movie(let movieModel):
                self.updateMovieTrends(movieModel: movieModel)
                break
            default:
                break
        }
    }
    
    func updateMovieTrends(movieModel: [MovieModel]) {
        movieLabel.text = ""
        for movie in movieModel {
            if let unpackedTitle = movie.movieTitle {
                movieLabel.text! += "\(unpackedTitle)\n"
            }
        }
    }
    
    @IBAction override func refreshWidget(_ sender: UIButton) {
        self.movieRequest.requestMovieTrend(mediaType: "all", windowTime: "day") { (response) in
            switch response {
                case .success(let movieModel):
                    self.updateMovieTrends(movieModel: movieModel)
                case .failure(let error):
                    print("[Error] during movie trend refresh widget data \(error.localizedDescription.debugDescription)")
            }
        }
    }
    
}
