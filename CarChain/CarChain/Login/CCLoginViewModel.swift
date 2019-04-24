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
        if !username.value.isEmpty && !password.value.isEmpty{
            Auth.auth().signIn(withEmail: username.value, password: password.value) { (user, error) in
                guard let user = user?.user else {self.showError(); return}
                self.loginSuccess(user)
            }
        }
        else{
            UIAlertController(title: "Error", message: "Data missing", preferredStyle: .alert).show()
        }
    }
    
    func loginSuccess(_ user: User){
        UserDefaults.standard.set(true, forKey: k.userRegistered)
        coordinator?.navigateToMap()
    }
    
    func showError(){
        UIAlertController(title: "Error", message: "User/password incorrect", preferredStyle: .alert).show()
    }
    
    func registerButtonPressed(){
        coordinator?.navigateToRegister()
    }
}
