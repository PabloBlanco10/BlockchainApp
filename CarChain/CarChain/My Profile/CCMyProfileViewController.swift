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
    
    
    override func viewDidLoad() {
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
}
