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

final class CCCoordinator: Coordinator{
    func start() {
        setRootController()
    }
    
    func setRootController() {
        navigator?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: false)
    }
}

struct CCAppNavigator {
    
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


