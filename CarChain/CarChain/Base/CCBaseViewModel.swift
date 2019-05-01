//
//  CCBaseViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 27/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCBaseViewModel : NSObject{

    func showError(){ UIAlertController(title: "Error", message: "Something gone wrong", preferredStyle: .alert).show() }

}
