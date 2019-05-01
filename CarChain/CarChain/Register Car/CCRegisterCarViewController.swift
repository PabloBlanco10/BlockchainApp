//
//  CCRegisterCarViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 28/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCRegisterCarViewController: CCBaseViewController, UITextFieldDelegate {

    var viewModel : CCRegisterCarViewModel?

    @IBOutlet weak var registerCarButton: CCButton!
    @IBOutlet weak var registerCarTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel(){
        _ = registerCarButton.rx.tap.subscribe(){value in self.viewModel?.registerCarButtonAction(self.registerCarTextfield.text, self)}
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 7
    }

}
