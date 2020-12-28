//
//  MicroserviceViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 21/11/2020.
//

import UIKit
import OAuthSwift
import SafariServices
import Nuke

protocol UpdateWidgetToService: AnyObject {
    func updateWidget(widget: Constants.ServicesModelData, selectedService: ServiceModel)
}

class ServiceViewController: UIViewController {
    @IBOutlet var servicesTableView: UITableView!
    var oauthSwift: OAuth2Swift?
    var servicesWithAuthentification: Dictionary<String, Dictionary<String, String>> = AppCredentials.credentials
    var selectedServiceName: String = ""
    var servicesList: [ServiceModel] = []
    var selectedService: ServiceModel!
    weak var delegate: UpdateServiceToHome?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.servicesTableView.dataSource = self
        self.servicesTableView.delegate = self
        self.servicesTableView.rowHeight = 80
        self.servicesTableView.allowsSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.servicesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((segue.identifier?.contains("WidgetConfigurationVC")) != nil) {
            if let widgetConfVC = segue.destination as? WidgetConfigViewController {
                widgetConfVC.serviceImageString = self.selectedService.urlImage
                widgetConfVC.serviceName = self.selectedServiceName
                widgetConfVC.selectedService = self.selectedService
                widgetConfVC.delegate = self
            }
        }
    }
}

//MARK: - UITableView

extension ServiceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServicesTableViewCell.identifier, for: indexPath) as! ServicesTableViewCell
        let serviceLabel = self.servicesList[indexPath.row].serviceName
        let serviceImage = self.servicesList[indexPath.row].urlImage
        cell.configure(serviceImageUrl: serviceImage, serviceLabel: serviceLabel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedService = self.servicesList[indexPath.row]
        self.selectedServiceName = self.selectedService.serviceName
        if let unpackedService = self.servicesWithAuthentification[self.selectedService.serviceName] {
            if let unpackedClientId = unpackedService[AppCredentials.clientIdKey], let unpackedClientSecret = unpackedService[AppCredentials.clientSecretKey] {
                self.redirectToGithubOauth(clientId: unpackedClientId, clientSecret: unpackedClientSecret)
            }
        } else {
            self.performSegue(withIdentifier: self.selectedServiceName + "WidgetConfigurationVC", sender: self)
        }
    }
}

//MARK: - Authentification Oauth2

extension ServiceViewController {
    private func getUrlHandler() -> OAuthSwiftURLHandlerType {
        let handler = SafariURLHandler(viewController: self, oauthSwift: self.oauthSwift!)
        handler.presentCompletion = {
            print("Safari presented")
        }
        handler.dismissCompletion = {
            print("Safari dismissed")
        }
        handler.factory = { url in
            let controller = SFSafariViewController(url: url)
            return controller
        }
        return handler
    }
    
    private func redirectToGithubOauth(clientId: String, clientSecret: String) {
        let authorizeUrl = self.selectedService.authorizeUrl
        let accessTokenUrl = self.selectedService.accessToken
        if let unpackedAuthorizeUrl = authorizeUrl, let unpackedAccessToken = accessTokenUrl {
            let oauthswift = OAuth2Swift(
                consumerKey: clientId,
                consumerSecret: clientSecret,
                authorizeUrl: unpackedAuthorizeUrl,
                accessTokenUrl: unpackedAccessToken,
                responseType: "code"
            )
            self.oauthSwift = oauthswift
            oauthswift.encodeCallbackURL = true
            oauthswift.encodeCallbackURLQuery = false
            oauthswift.authorizeURLHandler = self.getUrlHandler()
            let state = generateState(withLength: 20)
            let _ = oauthswift.authorize(
                withCallbackURL: URL(string: "Dashboard-callback://oauth-callback/")!, scope: "user,repo", state: state) { result in
                switch result {
                    case .success(let successResponse):
                        self.selectedService.oauthToken = successResponse.credential.oauthToken
                        self.performSegue(withIdentifier: self.selectedServiceName + "WidgetConfigurationVC", sender: self)
                    case .failure(let error):
                        print(error.description)
                }
            }
        }
    }
}

//MARK: - UpdateWidgetToService Protocol

extension ServiceViewController: UpdateWidgetToService {
    func updateWidget(widget: Constants.ServicesModelData, selectedService: ServiceModel) {
        delegate?.updateServices(newService: widget, selectedService: selectedService)
    }
}
