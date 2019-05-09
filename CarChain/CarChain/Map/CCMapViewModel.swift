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
import Foundation

class CCMapViewModel : CCBaseViewModel {

    var rentedCarViewHidden = Variable(true)
    let coordinator : CCMapCoordinator?
    let plate = Variable<String>("-")
    var plateSelected : String = "-"
    var vc : CCMapViewController?

    init(_ coordinator:CCMapCoordinator?) { self.coordinator = coordinator ; super.init(); setup() }
    
    func setup(){
        plate.value = UserSession.sharedInstance.plate
    }
    
    func viewWillAppear(){
        setup()
    }
    
    func viewDidLoad(){
        perfomUserCar(){ value in
            guard let value = value else{return}
            UserSession.sharedInstance.plate = (value[""] as! String)
            self.setup()
        }
    }
    
    func perfomUserCar(completion :@escaping ( _ result : [String:Any]?) -> () ){
        CCSmartContractManager().getUserCar(UserSession.sharedInstance.user?.uid ?? ""){value in
            completion(value)
        }
    }

    func rentCar(_ plate : String, _ vc : CCMapViewController){
        plateSelected = plate
        self.vc = vc
        vc.showLoader()
        CCSmartContractManager().rentCar(plate, UserSession.sharedInstance.user?.uid ?? ""){value in
            if value == nil {vc.hideLoader()
                ; self.showError() }
            else{
                self.perform(#selector(self.rentCarSuccess), with: nil, afterDelay: 15.0)}
        }
    }
    
    func returnCar( _ vc : CCMapViewController){
        vc.showLoader()
        CCSmartContractManager().returnCar(UserSession.sharedInstance.plate, UserSession.sharedInstance.user?.uid ?? ""){value in
            if value == nil {vc.hideLoader(); self.showError() }
            else{ self.perform(#selector(self.returnCarSuccess), with: nil, afterDelay: 15.0)}
        }
    }
    
    @objc func rentCarSuccess(){
        CCSmartContractManager().getUserCar(UserSession.sharedInstance.user?.uid ?? ""){value in
            self.vc?.hideLoader()
            guard let value = value else { self.showError() ; return}
            if value[""] as! String == "-" { self.showError() }
            else{
                self.rentedCarViewHidden.value = false
                self.plate.value = self.plateSelected
                self.updatePlateValue(self.plateSelected)
                UIAlertController(title: "Car rented succesfully", message: "Take a ride!", preferredStyle: .alert).show()
            }
        }
    }
    
    @objc func returnCarSuccess(){
        rentedCarViewHidden.value = true
        plate.value = "-"
        updatePlateValue("-")
        vc?.hideLoader()
        UIAlertController(title: "Car returned succesfully", message: "Take another ride!", preferredStyle: .alert).show()
    }
    
    func updatePlateValue(_ plate : String){
        UserSession.sharedInstance.plate = plate
        UserDefaults.standard.setValue(plate, forKey: k.UserDefaults.plate)
    }
}
