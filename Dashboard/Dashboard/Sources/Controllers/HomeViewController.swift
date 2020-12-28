//
//  ViewController.swift
//  Dashboard
//
//  Created by Valentin Mille on 18/11/2020.
//

import UIKit
import Nuke

protocol UpdateServiceToHome: AnyObject {
    func updateServices(newService: Constants.ServicesModelData, selectedService: ServiceModel)
}

class HomeViewController: UIViewController {

    @IBOutlet var addWidgetButton: UIButton!
    @IBOutlet var widgetCollectionView: UICollectionView!
    @IBOutlet var profileButton: UIBarButtonItem!
    var userModel: UserModel?
    private var servicesAvailable: [ServiceModel] = []
    var currentUserServices: [(ServiceModel, Constants.ServicesModelData?)] = []
    private var serviceRequests: ServiceRequest = ServiceRequest()
    private var userRequests: UserRequest = UserRequest()
    var selectedIndex = -1
    private var selectedCells: [IndexPath] = []
    private var selectedIndexToDelete = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addWidgetButton.layer.cornerRadius = self.addWidgetButton.frame.width / 2
        self.widgetCollectionView.delegate = self
        self.widgetCollectionView.dataSource = self
        self.configureCollectionViewCells()
        self.setupCollectionView()
        self.widgetCollectionView.selectionFollowsFocus = false
        self.initializeGesture()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    func configureCollectionViewCells() {
        self.widgetCollectionView.register(MovieWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: MovieWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(NasaWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: NasaWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(TrumpWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: TrumpWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(CovidWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: CovidWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(WeatherWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: WeatherWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(CinemaWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: CinemaWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(GithubWidgetCollectionViewCell.widgetNib(), forCellWithReuseIdentifier: GithubWidgetCollectionViewCell.widgetIdentifier)
        
        self.widgetCollectionView.register(WidgetCollectionViewCell.baseWidgetNib(), forCellWithReuseIdentifier: WidgetCollectionViewCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.widgetCollectionView.isEditing = false
        self.widgetCollectionView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.addWidgetButton.isEnabled = !editing
        self.addWidgetButton.isHidden = editing
        self.widgetCollectionView.reloadData()
        self.profileButton.isEnabled = !editing
        self.widgetCollectionView.allowsMultipleSelection = editing
        self.widgetCollectionView.indexPathsForSelectedItems?.forEach({ (indexPath) in
            self.widgetCollectionView.deselectItem(at: indexPath, animated: false)
        })
        self.widgetCollectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = self.widgetCollectionView.cellForItem(at: indexPath) as! WidgetCollectionViewCell
            cell.isEditing = editing
        }
    }

    private func initializeGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        self.widgetCollectionView.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
            case .began:
                guard let targetIndexPath = widgetCollectionView.indexPathForItem(at: gesture.location(in: widgetCollectionView)) else {
                    return
                }
                widgetCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            case .changed:
                widgetCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: widgetCollectionView))
            case .ended:
                widgetCollectionView.endInteractiveMovement()
            default:
                widgetCollectionView.cancelInteractiveMovement()
        }
    }
    
    func resetSelectedIndex() {
        self.selectedIndex = -1
    }
    
    private func setupCollectionView() {
        self.setupCollectionViewLayout()
    }

    private func setupCollectionViewLayout() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 5
        let interItemSpacing: CGFloat = 5
        let width = (view.frame.size.width / 2) - (interItemSpacing * 4)
        let height = width
        collectionViewLayout.itemSize = CGSize(width: width, height: height)
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = lineSpacing
        collectionViewLayout.minimumInteritemSpacing = interItemSpacing
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.widgetCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    private func extandWidgetCell() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 5
        let interItemSpacing: CGFloat = 5
        let width = view.frame.size.width
        let height = width - interItemSpacing
        collectionViewLayout.itemSize = CGSize(width: width, height: height)
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = lineSpacing
        collectionViewLayout.minimumInteritemSpacing = interItemSpacing
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.widgetCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToServicesList" {
            if let serviceListVC = segue.destination as? ServiceViewController {
                serviceListVC.servicesList = self.servicesAvailable
                serviceListVC.delegate = self
            }
        }
    }

    @IBAction func AddServiceAction(_ sender: UIButton) {
        if self.servicesAvailable.isEmpty {
            self.serviceRequests.getServices { (response) in
                switch response {
                    case .success(let services):
                        self.servicesAvailable = services
                        self.performSegue(withIdentifier: "GoToServicesList", sender: self)
                    case .failure(let error):
                        print("[Error] while requesting services \(error.localizedDescription.debugDescription)")
                }
            }
        } else {
            self.performSegue(withIdentifier: "GoToServicesList", sender: self)
        }
    }
    
    func askDeconnectionConfirmationAlert() {
        let alert = UIAlertController(title: "Log Out", message: "Do you want to continue ?", preferredStyle: .alert)
        
        let dismissAction = (UIAlertAction(title: "No", style: .cancel, handler: { action in
            print("dismiss")
        }))
        
        let deconnectionAction = (UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(dismissAction)
        alert.addAction(deconnectionAction)
        present(alert, animated: true)
    }
    
    @IBAction func deconnectionAction(_ sender: UIBarButtonItem) {
        self.askDeconnectionConfirmationAlert()
    }
}

//MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentUserServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = self.currentUserServices[indexPath.row].0.serviceName + "WidgetCell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: WidgetCollectionViewCell.identifier, for: indexPath) as! WidgetCollectionViewCell
        switch identifier {
            case NasaWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! NasaWidgetCollectionViewCell
            case GithubWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GithubWidgetCollectionViewCell
            case TrumpWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TrumpWidgetCollectionViewCell
            case MovieWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieWidgetCollectionViewCell
            case CovidWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CovidWidgetCollectionViewCell
            case WeatherWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WeatherWidgetCollectionViewCell
            case CinemaWidgetCollectionViewCell.widgetIdentifier:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CinemaWidgetCollectionViewCell
            default:
                break
        }
        cell.serviceLabel.text = self.currentUserServices[indexPath.row].0.serviceName
        if let unpackedUrl = URL(string: self.currentUserServices[indexPath.row].0.urlImage) {
            Nuke.loadImage(with: unpackedUrl, into: cell.widgetIcon)
        }
        if let unpackedModel = self.currentUserServices[indexPath.row].1 {
            cell.configureWidget(serviceModel: unpackedModel)
        }
        cell.isEditing = isEditing
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = self.currentUserServices.remove(at: sourceIndexPath.row)
        self.currentUserServices.insert(item, at: destinationIndexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (isEditing) {
            if let index = self.selectedCells.firstIndex(where: { $0 == indexPath }) {
                self.selectedCells.remove(at: index)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (isEditing) {
            let serviceId = self.currentUserServices[indexPath.row].0.serviceId
            if let userId = self.userModel?.userId {
                self.serviceRequests.deleteServiceUser(userId: userId, serviceId: serviceId) { (response) in
                    switch response {
                        case .success(_):
                            self.currentUserServices.remove(at: indexPath.row)
                            self.widgetCollectionView.deleteItems(at: [indexPath])
                            self.widgetCollectionView.reloadData()
                        case .failure(let error):
                            print("[Error] while deleting service to user \(error.localizedDescription.debugDescription)")
                    }
                }
            }
        } else {
            let lastSelectedIndex = self.selectedIndex
            self.selectedIndex = indexPath.row
            if self.selectedIndex == lastSelectedIndex {
                self.selectedIndex = -1
            }
            collectionView.performBatchUpdates(nil, completion: nil)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 5
        if self.selectedIndex == indexPath.row {
            let width = self.view.frame.width - (interItemSpacing * 6)
            let height : CGFloat = width
            return CGSize(width: width, height: height)
        } else {
            let width = (self.view.frame.size.width / 2) - (interItemSpacing * 4)
            let height = width
            return CGSize(width: width, height: height)
        }
    }
}

//MARK: - UpdateServiceToHome Protocol

extension HomeViewController: UpdateServiceToHome {
    func updateServices(newService: Constants.ServicesModelData, selectedService: ServiceModel) {
        if let unpackedUserId = self.userModel?.userId {
            self.serviceRequests.addServiceToUser(userId: unpackedUserId, serviceId: selectedService.serviceId) { (result) in
                switch (result) {
                    case .success(_):
                        self.currentUserServices.append((selectedService, newService))
                        self.widgetCollectionView.reloadData()
                    case .failure(let error):
                        print("[Error] while requesting to post new service to user \(error.localizedDescription.debugDescription)")
                }
            }
        }
    }
}
