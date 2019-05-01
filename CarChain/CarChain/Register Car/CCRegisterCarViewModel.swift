//
//  CCRegisterCarViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 28/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCRegisterCarViewModel: CCBaseViewModel {
    
    let coordinator : CCRegisterCarCoordinator?
    
    init(_ coordinator:CCRegisterCarCoordinator?) { self.coordinator = coordinator }
    
    func registerCarButtonAction(_ plate : String?, _ vc : CCRegisterCarViewController){
        guard let plate = plate, plate != "" else {return}
        if !plate.isValidPlate() || !CCVehicle.vehiclePlates.contains(plate){
            UIAlertController(title: "Error", message: "Invalid plate", preferredStyle: .alert).show()
            return
        }
        else{
            vc.showLoader()
            CCSmartContractManager().registerNewCar(plate){value in
                vc.hideLoader()
                if value == nil {self.showError()}
                else{UIAlertController(title: "Great!", message: "Car registered succesfully!", preferredStyle: .alert).show()}
            }
        }
    }
    
}
