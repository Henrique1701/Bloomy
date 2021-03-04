//
//  UserViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 09/12/20.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet var healthButton: UIButton!
    @IBOutlet var leisureButton: UIButton!
    @IBOutlet var mindfulnessButton: UIButton!
    @IBOutlet var lovedsButton: UIButton!
    @IBOutlet var profileImageButton: UIButton!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.userNameLabel.text = UserManager.shared.getUserName()
        self.buttonsToShow()
        self.setupNavigationController()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    func buttonsToShow() {
        if (IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue) == nil) {
            self.healthButton.isHidden = true
        }
        
        if (IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue) == nil) {
            self.leisureButton.isHidden = true
        }
        
        if (IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue) == nil) {
            self.mindfulnessButton.isHidden = true
        }
        
        if (IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue) == nil) {
            self.lovedsButton.isHidden = true
        }
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? JourneyCollectionViewController
        
        if segue.identifier == "healthToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue)!
        } else if segue.identifier == "leisureToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)!
        } else if segue.identifier == "mindfulnessToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)!
        } else if segue.identifier == "lovedsToJourney" {
            destination?.island = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)!
        }
    }
}
extension UserViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.profileImage.image = image
        profileImage.layer.cornerRadius = (profileImage.frame.size.width)/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.layoutIfNeeded()
    }
}

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    
}
