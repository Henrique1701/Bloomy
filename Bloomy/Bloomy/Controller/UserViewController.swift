//
//  UserViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 09/12/20.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var healthButton: UIButton!
    @IBOutlet var leisureButton: UIButton!
    @IBOutlet var mindfulnessButton: UIButton!
    @IBOutlet var lovedsButton: UIButton!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userNameLabel.text = UserManager.shared.getUserName()
        self.setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buttonsToShow()
    }
    
    func showAlert(islandName: String) {
        let alert = UIAlertController(title: "", message: "Tente ir em 'Editar ilhas' que fica nas configurações e selecionar a ilha de \(islandName)", preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "fechar", style: .default) { _ in }
        alert.addAction(closeButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showJourney(islandName: String) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Journey", bundle: nil)
        let destination = storyboard.instantiateInitialViewController() as! JourneyCollectionViewController
        destination.island = IslandManager.shared.getIsland(withName: islandName)!
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func touchedHealthButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedHealth") {
            showJourney(islandName: IslandsNames.health.rawValue)
        } else {
            showAlert(islandName: "saúde")
        }
    }
    
    @IBAction func touchedLeisureButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedLeisure") {
            showJourney(islandName: IslandsNames.leisure.rawValue)
        } else {
            showAlert(islandName: "lazer")
        }
    }
    
    @IBAction func touchedMindfulnessButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedMindfulness") {
            showJourney(islandName: IslandsNames.mindfulness.rawValue)
        } else {
            showAlert(islandName: "atenção plena")
        }
    }
    
    @IBAction func touchedLovedButton(_ sender: Any) {
        if defaults.bool(forKey: "selectedLoveds") {
            showJourney(islandName: IslandsNames.loveds.rawValue)
        } else {
            showAlert(islandName: "pessoas queridas")
        }
    }
    
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    func buttonsToShow() {
        if (defaults.bool(forKey: "selectedHealth")) {
            self.healthButton.alpha = 1
        } else {
            self.healthButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedLeisure")) {
            self.leisureButton.alpha = 1
        } else {
            self.leisureButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedMindfulness")) {
            self.mindfulnessButton.alpha = 1
        } else {
            self.mindfulnessButton.alpha = 0.6
        }
        
        if (defaults.bool(forKey: "selectedLoveds")) {
            self.lovedsButton.alpha = 1
        } else {
            self.lovedsButton.alpha = 0.6
        }
    }
}
