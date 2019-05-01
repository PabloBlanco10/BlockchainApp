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
    
    let model = CCMyProfileModel()
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
        model.performUserCredit(){value in self.setupCredit(value)}
        model.perfomUserCar(){value in self.setupCar(value)}
    }
    
    func setupCredit(_ value : [String : Any]){
        let cred = Int((value[""] as! BigUInt))
        credit.value = "\(cred)"
    }
    
    func setupCar(_ value : [String : Any]?){
        guard let value = value else{rentedCar.value = "No car rented"; return}
        rentedCar.value = (value[""] as! String)
        UserSession.sharedInstance.plate = rentedCar.value
    }
}
