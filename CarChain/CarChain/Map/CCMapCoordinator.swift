//
//  CCMapCoordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCMapCoordinator: Coordinator {
    static let storyboardId = "Map"
    
    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }

    func start(){
        navigator?.setViewControllers([viewController()] as [UIViewController], animated: false)
    }
    
    func viewController() -> CCMapViewController {
        let vc = UIStoryboard(name: CCMapCoordinator.storyboardId, bundle: nil).instantiateInitialViewController() as! CCMapViewController
        vc.viewModel = CCMapViewModel(self)
        return vc
    }
    
//    func navigateToUserDetails( _ viewModel : FLUserDetailsViewModel){
//        _ = FLUserDetailsCoordinator.init(navigator: navigationController, viewModel: viewModel)
//    }
//    
//    func navigateToAddUser(){
//        _ = FLSearchUserCoordinator.init(navigator: navigationController).start()
//    }
}
