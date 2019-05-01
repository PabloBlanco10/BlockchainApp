//
//  CCRegisterViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import Firebase
import RxCocoa
import RxSwift

class CCRegisterViewModel : CCBaseViewModel {
    
    let coordinator : CCRegisterCoordinator?
    var email = Variable<String>("")
    var password = Variable<String>("")

    init(_ coordinator:CCRegisterCoordinator?) {
        self.coordinator = coordinator
    }
    
    func registerUser(_ vc : CCRegisterViewController){
        if email.value.isValidEmail(){
            vc.showLoader()
            Auth.auth().createUser(withEmail: email.value, password: password.value) { (authResult, error) in
                guard let user = authResult?.user else {
                    vc.hideLoader()
                    UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert).show()

                    return }
                CCSmartContractManager().registerNewUser(user.uid) { value in
                    vc.hideLoader()
                    if value == nil {self.showError()}
                    else{UIAlertController(title: "User registered succesfully", message: "Log in CarChain!", preferredStyle: .alert).show()}
                }
            }
        }
        else{
            UIAlertController(title: "Error", message: "Email not valid", preferredStyle: .alert).show()
        }
    }
}
