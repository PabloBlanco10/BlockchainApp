//
//  CCMyProfileModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 27/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCMyProfileModel: NSObject {
    
    override init() {
        super.init()
    }
    
    func performUserCredit(completion :@escaping ( _ result : [String:Any]) -> () ){
        CCSmartContractManager().getUserCredit(UserSession.sharedInstance.user?.uid ?? ""){value in
            completion(value)
        }
    }
    
    func perfomUserCar(completion :@escaping ( _ result : [String:Any]?) -> () ){
        CCSmartContractManager().getUserCar(UserSession.sharedInstance.user?.uid ?? ""){value in
            completion(value)
        }
    }

}
