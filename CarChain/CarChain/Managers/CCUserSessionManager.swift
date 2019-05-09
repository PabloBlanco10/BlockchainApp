//
//  CCUserSessionManager.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 25/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UserSession: NSObject {
    static let sharedInstance = UserSession()
    
    var user : User?
    var isManager = false
    var plate : String = {
        if UserDefaults.standard.object(forKey: k.UserDefaults.plate) != nil {
            return UserDefaults.standard.value(forKey: k.UserDefaults.plate) as! String
        }
        else{ return "-" }
    }()
    
    override init() {
        user = nil
        super.init()
    }
    
    func saveUser(_ user : User, _ username : String, _ password: String){
        self.user = user
        if username == "manager@gmail.com" {isManager = true} else {isManager = false}
        UserDefaults.standard.set(username, forKey: k.UserDefaults.username)
        UserDefaults.standard.set(password, forKey: k.UserDefaults.password)
    }
}
