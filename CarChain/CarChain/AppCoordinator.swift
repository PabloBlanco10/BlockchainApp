//
//  Coordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit


class Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigator: UINavigationController?
    init(_ navigator: UINavigationController?) {self.navigator = navigator}
    func back(){ //Cancel all previous request.
        navigator?.popViewController(animated: true)
    }
}

final class AppCoordinator: Coordinator{
    func start() {
        setRootController()
    }
    
    func setRootController() {
        if checkUserRegistered(){
            if navigator?.children.count ?? 0 > 0 {
                navigator?.viewControllers.removeAll()
            }
            navigator?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: false)
        }
        else{
            CCLoginCoordinator(navigator).start()
        }
    }
    
    func checkUserRegistered() -> Bool{
        return UserDefaults.standard.bool(forKey: k.userRegistered)
    }
    
    static func topNavigator() -> UINavigationController? {
        if let navigation = AppDelegate.appCoordinator?.navigator?.presentedViewController as? UINavigationController {return navigation}
        else {return AppDelegate.appCoordinator?.navigator}
    }
}

struct AppNavigator {
    
    static func source(_ navigator: UINavigationController?,goTo destiny: k.Destiny) {
        switch destiny {
        case .map:
            CCMapCoordinator(navigator).start()
        case .myprofile:
            CCMyProfileCoordinator(navigator).start()
        }
    }
    
    static func goTo(_ navigator: UINavigationController?,goTo destiny: k.Destiny, _ vc : CCBaseViewController) {
        switch destiny {
        case .map:
            CCMapCoordinator(navigator).show([vc])
        case .myprofile:
            CCMyProfileCoordinator(navigator).show([vc])
        }
    }
}


