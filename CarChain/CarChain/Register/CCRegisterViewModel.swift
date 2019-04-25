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

class CCRegisterViewModel {
    
    let coordinator : CCRegisterCoordinator?
    var email = Variable<String>("")
    var password = Variable<String>("")

    init(_ coordinator:CCRegisterCoordinator?) {
        self.coordinator = coordinator
    }
    
    func registerUser(_ vc : CCRegisterViewController){
        if email.value.isValidEmail(){
            vc.showSpinner(onView: vc.view)
            Auth.auth().createUser(withEmail: email.value, password: password.value) { (authResult, error) in
                vc.removeSpinner()
                guard let user = authResult?.user else { return }
                self.saveUser(user)
            }
        }
        else{
            UIAlertController(title: "Error", message: "Email not valid", preferredStyle: .alert).show()
        }
    }
    
    func saveUser(_ user : User){
        
    }
    
    
}
