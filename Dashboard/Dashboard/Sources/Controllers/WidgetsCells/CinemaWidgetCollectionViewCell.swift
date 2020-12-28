//
//  CinemaWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 15/12/2020.
//

import UIKit

class CinemaWidgetCollectionViewCell: WidgetCollectionViewCell {
    static let widgetIdentifier = "CinemaWidgetCell"
    @IBOutlet var cinemaLabel: UILabel!
    private let cinemaRequest = CinemaRequest()
    private var movieTitle = ""
    
    static func widgetNib() -> UINib {
        return UINib(nibName: "CinemaWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .cinema(let cinemaModel):
                self.updateLabel(cinemaModel: cinemaModel)
            default:
                break
        }
    }
    
    private func updateLabel(cinemaModel: CinemaModel) {
        let message = "🎬 Film Info 🎬\nTitle: \(cinemaModel.title)\nRelease Date: \(cinemaModel.released)\nGenre: \(cinemaModel.genre)\nDirector: \(cinemaModel.director)\nActors: \(cinemaModel.actors)"
        cinemaLabel.text = message
        self.movieTitle = cinemaModel.title
    }

    @IBAction override func refreshWidget(_ sender: UIButton) {
        self.cinemaRequest.requestCinemaInformations(movieTitle: self.movieTitle) { (response) in
            switch response {
                case .success(let cinemaModel):
                    self.updateLabel(cinemaModel: cinemaModel)
                case .failure(let error):
                    print("[Error] during cinema refresh widget data \(error.localizedDescription.debugDescription)")
            }
        }
    }
    
    
}
