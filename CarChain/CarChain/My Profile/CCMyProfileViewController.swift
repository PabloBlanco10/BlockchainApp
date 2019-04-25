//
//  CCMyProfileViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCMyProfileViewController : CCBaseViewController {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var car: UILabel!
    var viewModel : CCMyProfileViewModel?
    
    override func viewDidLoad() {
        bindViewModel()
    }
    
    func bindViewModel() {
        _ = viewModel?.username.asObservable().bind(to: username.rx.text)
        _ = viewModel?.userId.asObservable().bind(to: userId.rx.text)
        _ = viewModel?.credit.asObservable().bind(to: credit.rx.text)
        _ = viewModel?.rentedCar.asObservable().bind(to: car.rx.text)
    }
}
