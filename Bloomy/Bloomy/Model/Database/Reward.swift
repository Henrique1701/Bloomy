//
//  Reward.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 25/11/20.
//

import Foundation
import CoreData
import UIKit

struct RewardManager {
    static let shared = RewardManager()
    static var reward: Reward?
    // MARK: Create new Reward
    public func newReward(withId rewardId: String) -> Reward? {
        
        let rewardObject = NSEntityDescription.insertNewObject(forEntityName: "Reward", into: coreDataContext)
        
        guard let reward = rewardObject as? Reward else {
            fatalError("Could not find Reward Entity")
        }
        reward.id = rewardId
        return self.saveContext() ? reward : nil
    }
    
    // MARK: Read Rewards
    //Fetches a reward with a specific rewardId
    public func getReward(withId rewardId: String) -> Reward? {
        let fetchRequest = NSFetchRequest<Reward>(entityName: "Reward")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "rewardId == %@", rewardId)
        do {
            let reward = try coreDataContext.fetch(fetchRequest)
            if !reward.isEmpty { return reward[0] }
        } catch let error {
            print("We couldn't find the reward. \n \(error)")
        }
        
        return nil
    }
    
    //Fetches all rewards
    public func getRewards() -> [Reward]? {
        let fetchRequest = NSFetchRequest<Reward>(entityName: "Reward")
        
        do {
            let rewards = try coreDataContext.fetch(fetchRequest)
            if !rewards.isEmpty { return rewards }
        } catch let fetchError {
            print("Failed to fetch Rewards: \(fetchError)")
        }
        
        return nil
    }
    
    //Returns all of the rewards that are being shown
    public func getShownRewards() -> [Reward] {
        var rewardsShown: [Reward] = []
        if let rewards = getRewards() {
            for reward in rewards where reward.isShown {
                rewardsShown.append(reward)
            }
        } else {
            print("Não encontrei as recompensas que estão sendo exibidas")
            
        }
        return rewardsShown
    }
    
    // MARK: Update Reward
    // Update attribute that tells if the reward is shown
    public func updateShown(withId rewardId: String, to newValue: Bool) -> Bool {
        guard let reward = getReward(withId: rewardId) else { fatalError("Coud not find the reward with id \(rewardId)") }
        reward.isShown = newValue

        return self.saveContext()
    }
    
    // MARK: Delete Reward
    //From location
    public func deleteReward(withId rewardId: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<Reward>(entityName: "Reward")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "rewardId == %@", rewardId)
        
        do {
            let reward = try coreDataContext.fetch(fetchRequest)
            
            if !reward.isEmpty {
                coreDataContext.delete(reward[0])
                return self.saveContext()
            } else {
                print("The reward from the \(rewardId) could not be found!")
            }
        } catch {
            print("Error deleting the reward \(rewardId)")
        }
        
        return false
    }
    
    // Associa recompensa a uma ilha
    public func setIsland (toReward rewardId: String, island: Island) -> Bool {
        guard let reward = getReward(withId: rewardId) else { fatalError("Coud not find \(rewardId) Reward") }
        reward.rewardToIsland = island
        return saveContext()
    }
    
    // MARK: Save Context (auxiliar)
    public func saveContext() -> Bool {
        
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the reward. Try again later. \n \(error)")
        }
        
        return false
    }
}
