//
//  LoginCoordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCLoginCoordinator : Coordinator {
    static let storyboardId = "Login"
    
    func start(){
        navigator?.setViewControllers([viewController()] as [UIViewController], animated: false)
    }

    func viewController() -> CCLoginViewController {
        let vc : CCLoginViewController = UIStoryboard(name: CCLoginCoordinator.storyboardId, bundle: nil).instantiateInitialViewController() as! CCLoginViewController
        vc.viewModel = CCLoginViewModel(self)
        return vc
    }
    
    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }
    
    func navigateToRegister(){
        CCRegisterCoordinator(navigator).start()
    }
    
    func navigateToMap(){
        navigator?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: false)
//        CCMapCoordinator(navigator).start()
    }
}
