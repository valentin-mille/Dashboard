//
//  MicroservicesTableViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 21/11/2020.
//

import UIKit
import Nuke

class ServicesTableViewCell: UITableViewCell {
    
    @IBOutlet var serviceImage: UIImageView!
    @IBOutlet var serviceLabel: UILabel!
    static let identifier = "ServiceCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(serviceImageUrl: String, serviceLabel: String) {
        let imageUrl = URL(string: serviceImageUrl)
        if let unpackedImageUrl = imageUrl {
            Nuke.loadImage(with: unpackedImageUrl, into: self.serviceImage)
        }
        self.serviceImage.layer.cornerRadius = self.serviceImage.frame.height / 2
        self.serviceLabel.text = serviceLabel
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = .systemBlue
        } else {
            self.contentView.backgroundColor = UIColor(named: Constants.Color.secondContainerColor)
        }
    }
}
