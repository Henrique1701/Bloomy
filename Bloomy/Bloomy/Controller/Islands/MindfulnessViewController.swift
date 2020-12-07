//
//  MindfulnessViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 01/12/20.
//

import UIKit

class MindfulnessViewController: UIViewController {
    @IBOutlet weak var challengeDayButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    let island = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)!
    var challengeObserver: NSObjectProtocol?
    var doneObserver: NSObjectProtocol?
    let teste = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseButtonToShow()
        setupStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        challengeObserver = NotificationCenter.default.addObserver(forName: .acceptChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            self.island.dailyChallenge?.accepted = true
            _ = IslandManager.shared.saveContext()
            self.chooseButtonToShow()
            self.loadViewIfNeeded()
        }
        
        doneObserver = NotificationCenter.default.addObserver(forName: .doneChallenge, object: nil, queue: OperationQueue.main) { (notification) in
            self.island.dailyChallenge?.done = true
            _ = IslandManager.shared.saveContext()
            self.chooseButtonToShow()
            self.showRewardPopUp()
            self.loadViewIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if challengeObserver != nil {
            NotificationCenter.default.removeObserver(challengeObserver!)
        }
        
        if doneObserver != nil {
            NotificationCenter.default.removeObserver(doneObserver!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChallengePopUpViewControllerSegue" {
            let popup = segue.destination as! ChallengePopUpViewController
            popup.summary = island.dailyChallenge?.summary ?? ""
        } else if (segue.identifier == "toDonePopUpViewControllerSegue") {
            let popup = segue.destination as! DonePopUpViewController
            popup.summary = island.dailyChallenge?.summary ?? ""
        }
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Semibold", size: 18) ?? UIFont()]
    }
    
    func setupStyle() {
        self.title = IslandsNames.mindfulness.rawValue
        // Ajusta o tamaho do titulo do botão
        self.challengeDayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // Configura a navigation controller
        setupNavigationController()
    }
    
    func chooseButtonToShow() {
        if (!(self.island.dailyChallenge?.accepted)!) {
            //se o desafio não foi aceito
            self.doneButton.isHidden = true
            self.challengeDayButton.isHidden = false
            self.challengeDayButton.isEnabled = true
            self.challengeDayButton.alpha = 1
        } else if ((self.island.dailyChallenge?.accepted)! && !(self.island.dailyChallenge?.done)!) {
            //se o desafio foi aceito mas n foi concluído
            self.challengeDayButton.isHidden = true
            self.doneButton.isHidden = false
        } else {
            //desafio aceito e concluído
            self.challengeDayButton.isHidden = false
            self.challengeDayButton.alpha = 0.5
            self.challengeDayButton.isEnabled = false
            self.doneButton.isHidden = true
        }
    }
    
    func showRewardPopUp() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "PopUps", bundle: nil)
        let popup = storyBoard.instantiateViewController(identifier: "RewardPopUp") as! RewardPopUpViewController
        popup.rewardImage = UIImage(named: "mushroom")
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overCurrentContext
        self.present(popup, animated: true)
    }
    
}
