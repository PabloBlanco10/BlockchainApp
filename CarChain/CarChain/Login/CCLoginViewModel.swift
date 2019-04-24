//
//  LoginViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

class CCLoginViewModel {
    
    let coordinator : CCLoginCoordinator?
    var username = Variable<String>("")
    var password = Variable<String>("")
    
    init(_ coordinator:CCLoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func loginButtonAction(){
        Auth.auth().signIn(withEmail: username.value, password: password.value) { (user, error) in
            guard let user = user?.user else {self.showError(); return}
            self.loginSuccess(user)
        }
    }
    
    func loginSuccess(_ user: User){
        coordinator?.navigateToMap()
    }
    
    func showError(){

    }
    
    func registerButtonPressed(){
        coordinator?.navigateToRegister()
    }
}
