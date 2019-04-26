//
//  CCMapViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CCMapViewModel {

    var rentedCarViewHidden = Variable(true)
    let coordinator : CCMapCoordinator?
    
    init(_ coordinator:CCMapCoordinator?) {
        self.coordinator = coordinator
    }
    
    func rentCar(){
        rentedCarViewHidden.value = false
    }
    
    func returnCar(){
        rentedCarViewHidden.value = true
    }

}
