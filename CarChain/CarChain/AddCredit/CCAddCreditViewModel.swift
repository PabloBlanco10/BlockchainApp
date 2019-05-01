//
//  CCAddCreditViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 27/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Web3

class CCAddCreditViewModel: CCBaseViewModel {
    
    let coordinator : CCAddCreditCoordinator?
    
    init(_ coordinator:CCAddCreditCoordinator?) { self.coordinator = coordinator }
    
    func addCreditButtonAction(_ credit : String?, _ view : CCAddCreditViewController){
        guard let credit = credit else { UIAlertController.init(title: "Error", message: "Insert credit quantity", preferredStyle: .alert).show(); return}
        if credit == "" || credit == "0" {UIAlertController.init(title: "Error", message: "Insert credit quantity", preferredStyle: .alert).show()}
        else{
            view.showLoader()
            CCSmartContractManager().addCredit(UserSession.sharedInstance.user?.uid ?? "", BigUInt(credit)!){ value in view.hideLoader()
                if value == nil { self.showError() }
                else{ self.addCreditSuccess() }
            }
        }
    }
    
    func addCreditSuccess(){
        UIAlertController(title: "Great!", message: "You made a deposit, enjoy renting cars!", preferredStyle: .alert).show()
    }
    
}
