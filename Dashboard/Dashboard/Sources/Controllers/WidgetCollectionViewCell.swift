//
//  BaseWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Valentin Mille on 13/12/2020.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell {
    static let identifier = "widgetCell"
    @IBOutlet var selectedLabel: UILabel!
    @IBOutlet var serviceLabel: UILabel!
    @IBOutlet var widgetIcon: UIImageView!
    @IBOutlet var refreshButton: UIButton!
    var isEditing: Bool = false {
        didSet {
            self.selectedLabel.isHidden = !isEditing
        }
    }
    
    static func baseWidgetNib() -> UINib {
        return UINib(nibName: "WidgetCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedLabel.text = "❌"
        self.backgroundColor = UIColor(named: Constants.Color.secondContainerColor)
        self.refreshButton.layer.cornerRadius = self.refreshButton.frame.height / 2
        self.widgetIcon.layer.cornerRadius = self.widgetIcon.frame.width / 2
        self.configureSelection()
    }
    
    private func configureSelection() {
        self.selectedLabel.layer.cornerRadius = self.selectedLabel.frame.height / 2
        self.selectedLabel.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 20
    }
    
    public func configure(widgetIcon: UIImageView, serviceName: String) {
        self.serviceLabel.text = serviceName
        self.widgetIcon = widgetIcon
    }
    
    public func configureWidget(serviceModel: Constants.ServicesModelData) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.selectedLabel.isHidden = !isEditing
    }
    
    
    @IBAction func refreshWidget(_ sender: UIButton) {
        
    }
}
