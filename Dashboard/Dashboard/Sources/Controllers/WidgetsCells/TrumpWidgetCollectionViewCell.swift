//
//  TrumpWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 15/12/2020.
//

import UIKit

class TrumpWidgetCollectionViewCell: WidgetCollectionViewCell {
    static let widgetIdentifier = "TrumpWidgetCell"
    @IBOutlet var quoteLabel: UILabel!
    private let trumpRequest = TrumpRequest()
    
    static func widgetNib() -> UINib {
        return UINib(nibName: "TrumpWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .trump(let trumpModel):
                self.quoteLabel.text = trumpModel.quote
            default:
                break
        }
    }
    
    @IBAction override func refreshWidget(_ sender: UIButton) {
        self.trumpRequest.requestTrumpQuote { (response) in
            switch response {
                case .success(let trumpModel):
                    self.quoteLabel.text = trumpModel.quote
                case .failure(let error):
                    print("[Error] during trump refresh widget data \(error.localizedDescription.debugDescription)")
            }
        }
    }
}
