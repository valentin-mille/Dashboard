//
//  GithubWidgetCollectionViewCell.swift
//  Dashboard
//
//  Created by Remi Poulenard on 15/12/2020.
//

import UIKit

class GithubWidgetCollectionViewCell: WidgetCollectionViewCell {

    static let widgetIdentifier = "GithubWidgetCell"
    private let githubRequest = GithubRequest()
    private var oauthToken = ""
    @IBOutlet weak var RepositoryTextField: UITextField!
    private var repositoryName: String = ""
    
    override func configureWidget(serviceModel: Constants.ServicesModelData) {
        switch serviceModel {
            case .github(let githubModel):
                if let unpackedAccessToken = githubModel.accessToken {
                    self.oauthToken = unpackedAccessToken
                    self.repositoryName = githubModel.name
                }
            default:
                break
        }
    }

    static func widgetNib() -> UINib {
        return UINib(nibName: "GithubWidgetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RepositoryTextField.textColor = UIColor.black
        RepositoryTextField.backgroundColor = UIColor.white
    }
    
    @IBAction func ConfirmRepository(_ sender: Any) {
        if (self.RepositoryTextField.text != nil && self.RepositoryTextField.text != "") {
            if let unpackedRepositoryName = self.RepositoryTextField.text {
                self.githubRequest.postGithubRepository(repositoryName: unpackedRepositoryName, accessToken: self.oauthToken) { (response) in
                    switch response {
                        case .success(_):
                            break
                        case .failure(let error):
                            print("[Error] during github post repo data \(error.localizedDescription.debugDescription)")
                    }
                }
            }
        } else {
            print("Error: repository name empty")
        }
    }
}
