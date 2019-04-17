//
//  CCLateralMenuTableViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MessageUI

class CCLateralMenuTableViewController: CCBaseViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var viewModel = CCLateralMenuTableViewModel()
    
    private var lastIndex = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        menuTableView.selectRow(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func bindViewModel(){
        viewModel.dataSource.bind(to: menuTableView.rx.items(cellIdentifier: CCLateralMenuTableViewCell.reuseId, cellType: CCLateralMenuTableViewCell.self)){row, element, cell in cell.setup(element)}.disposed(by: disposeBag)
        
        _ = menuTableView.rx.itemSelected.subscribe{value in
            if self.lastIndex != value.element{
                self.viewModel.navigateTo((value.element?.row)!, self.parent?.children[1] as! UINavigationController)}
            self.lastIndex = value.element!
            (self.parent as! CCLateralMenuViewController).menuState = .hide
            }.disposed(by: disposeBag)
    }
   
}

extension CCLateralMenuTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 3 }
    func numberOfSections(in tableView: UITableView) -> Int {return 1}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/9
    }
}

class CCLateralMenuTableViewCell: UITableViewCell {
    static let reuseId = "menuCell"
    @IBOutlet weak var titleLabel: UILabel!
    func setup(_ element : String){
        titleLabel.text = element
    }
}
