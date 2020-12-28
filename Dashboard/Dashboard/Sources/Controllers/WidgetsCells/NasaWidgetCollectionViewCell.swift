//
//  ImageCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 13/12/2020.
//

import UIKit
import Nuke

class NasaWidgetCollectionViewCell: WidgetCollectionViewCell {
    @IBOutlet var imageWidget: UIImageView!
    static let widgetIdentifier = "NasaWidgetCell"
    @IBOutlet var titleLabel: UILabel!
    private let nasaRequest = NasaRequest()
    
    static func widgetNib() -> UINib {
        return UINib(nibName: "NasaWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .nasa(let nasaModel):
                if let imageUrl = URL(string: nasaModel.url) {
                    Nuke.loadImage(with: imageUrl, into: self.imageWidget)
                    self.titleLabel.text = nasaModel.title
                }
            default:
                break
        }
    }
    
    @IBAction override func refreshWidget(_ sender: UIButton) {
        self.nasaRequest.requestNasaImage { (response) in
            switch response {
                case .success(let nasaModel):
                    if let imageUrl = URL(string: nasaModel.url) {
                        Nuke.loadImage(with: imageUrl, into: self.imageWidget)
                        self.titleLabel.text = nasaModel.title
                    }
                case .failure(let error):
                    print("[Error] during nasa refresh widget data \(error.localizedDescription.debugDescription)")
            }
        }
    }
}
