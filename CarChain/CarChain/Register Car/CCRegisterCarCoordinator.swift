//
//  CCRegisterCarCoordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 28/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCRegisterCarCoordinator: Coordinator {
    static let storyboardId = "RegisterCar"
    
    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }
    
    func start(){
        navigator?.setViewControllers([viewController()] as [UIViewController], animated: false)
    }
    
    func viewController() -> CCRegisterCarViewController {
        let vc = UIStoryboard(name: CCRegisterCarCoordinator.storyboardId, bundle: nil).instantiateInitialViewController() as! CCRegisterCarViewController
        vc.viewModel = CCRegisterCarViewModel(self)
        return vc
    }
}
