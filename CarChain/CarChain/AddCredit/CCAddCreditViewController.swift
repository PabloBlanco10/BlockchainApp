//
//  CCAddCreditViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 27/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCAddCreditViewController: CCBaseViewController, UITextFieldDelegate {
    
    let allowedCharacters = CharacterSet.decimalDigits
    var viewModel : CCAddCreditViewModel?

    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var addCreditButton: CCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel(){
        _ = addCreditButton.rx.tap.subscribe(){ value in self.viewModel?.addCreditButtonAction(self.creditTextField.text, self) }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: string)
        if allowedCharacters.isSuperset(of: characterSet){
            guard let textFieldText = textField.text, let rangeOfTextToReplace = Range(range, in: textFieldText) else {return false}
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 3
        }
        return false
    }
    
}
