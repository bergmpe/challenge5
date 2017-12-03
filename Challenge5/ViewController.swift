//
//  ViewController.swift
//  Challenge5
//
//  Created by padrao on 22/11/17.
//  Copyright © 2017 Williamberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //CoredataUtil.saveFriend(name: "ze", photo: Data.init(), telephone: "555")
        //print(CoredataUtil.getFriends())
        let p = CoredataUtil.getFriends()
        let c = NSDateComponents()
        c.year = 2015
        c.month = 8
        c.day = 31
        
        // Get NSDate given the above date components
        let date = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents)

        //CoredataUtil.addPayment(friend: p.first! as! FriendMO, date: date!, value: 150.0)
        p.forEach { (manageObject) in
            //print(manageObject.value(forKey: "friendPayment")!)
            let set = manageObject.value(forKey: "friendPayment") as! NSMutableSet
            set.forEach({ (s) in
                let pay = s as! PaymentMO
                print( pay.value )
            })
            
        }
    }


}

