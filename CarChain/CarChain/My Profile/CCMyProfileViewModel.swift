//
//  CCMyProfileViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Web3

class CCMyProfileViewModel {
    
    let coordinator : CCMyProfileCoordinator?
    let username = Variable<String>(UserSession.sharedInstance.user?.email ?? "")
    let userId = Variable<String>(UserSession.sharedInstance.user?.uid ?? "")
    let credit = Variable<String>(" ")
    let rentedCar = Variable<String>(" ")

    init(_ coordinator:CCMyProfileCoordinator?) {
        self.coordinator = coordinator
        performUserData()
    }
    
    func performUserData(){
        //add to model
        CCSmartContract().getUserData(BigUInt(1)){value in
            self.setup(value)
        }
    }
    
    func setup(_ value : [String : Any]){
        let cred = Int((value["credit"] as! BigUInt))
        credit.value = "\(cred)"
        
        let car = Int((value["carId"] as! BigUInt))
        if car != 0 {
            rentedCar.value = "\(car)"
        }
        else{
            rentedCar.value = "No car rented"
        }
    }
}
