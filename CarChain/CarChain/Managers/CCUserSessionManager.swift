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
    
    override init() {
        user = nil
        super.init()
    }
    
    func saveUser(_ user : User, _ username : String, _ password: String){
        self.user = user
        if username == "manager@gmail.com" {isManager = true}
        UserDefaults.standard.set(username, forKey: k.username)
        UserDefaults.standard.set(password, forKey: k.password)
    }
}
