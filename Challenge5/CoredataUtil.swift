//
//  CoredataUtil.swift
//  Challenge5
//
//  Created by Williamberg on 02/12/17.
//  Copyright © 2017 Williamberg. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoredataUtil{
    
    static var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func saveFriend(name: String, photo: Data, telephone: String){
        let entity =
            NSEntityDescription.entity(forEntityName: "Friend",
                                       in: context)!
        
        let friend = NSManagedObject(entity: entity, insertInto: context)
        
        friend.setValue(name, forKeyPath: "name")
        friend.setValuesForKeys(["name": name, "photo": photo, "telephone": telephone])
        saveContext()
    }
    
    static func getFriends() -> [NSManagedObject]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Friend")
        
        do {
             return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func update(friend: FriendMO, name: String?, photo: Data?, telephone: String?){
        if let newName = name{ friend.setValue(newName, forKey: "name") }
        if let newPhoto = photo{ friend.setValue(newPhoto, forKey: "photo") }
        if let newTelephone = telephone{ friend.setValue(newTelephone, forKey: "telephone") }
    }
    
    static func addPayment(friend: FriendMO, date: Date, value: Double){
        let entity =
            NSEntityDescription.entity(forEntityName: "Payment",
                                       in: context)!
        let payment = NSManagedObject(entity: entity, insertInto: context)
        payment.setValue(date, forKey: "date")
        payment.setValue(value, forKey: "value")
        let payments = friend.mutableSetValue(forKey: "friendPayment")
        payments.add(payment)
        saveContext()
    }
    
    static func getPayments(friend: FriendMO) -> [NSManagedObject]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Payment")
        let predicate = NSPredicate(format: "paymentsFriend = %@", friend)
        fetchRequest.predicate = predicate
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func addLoan(friend: FriendMO, originDate: Date, payDate: Date, value: Double){
        let entity =
            NSEntityDescription.entity(forEntityName: "Loan",
                                       in: context)!
        let loan = NSManagedObject(entity: entity, insertInto: context)
        loan.setValue(originDate, forKey: "origin_date")
        loan.setValue(payDate, forKey: "pay_date")
        loan.setValue(value, forKey: "value")
        let loans = friend.mutableSetValue(forKey: "friendLoan")
        loans.add(loan)
        saveContext()
    }
    
    static func getLoans(friend: FriendMO) -> [NSManagedObject]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Loan")
        let predicate = NSPredicate(format: "loansFriend = %@", friend)
        fetchRequest.predicate = predicate
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    private static func saveContext(){
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
