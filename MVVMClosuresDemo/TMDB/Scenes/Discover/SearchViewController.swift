//
//  SearchViewController.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/29.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    var viewModel: SearchViewModel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(SearhCell.self, forCellReuseIdentifier: String(describing: SearhCell.self))
        }
    }
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func bindViewModel() {
        
        let input = SearchViewModel.Input(searchText: searchTextField.rx.text.orEmpty.asDriver(),
                                          selectedCategoryIndex: segmentedControl.rx.value.asDriver(),
                                          selected: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.switchHidden
            .drive(segmentedControl.rx.isHidden)
            .disposed(by: dispose)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: dispose)
        
        output.results
            .drive(tableView.rx.items(cellIdentifier: String(describing: SearhCell.self), cellType: SearhCell.self)) {
                (row, element, cell) in
                cell.configure(withSearchResultItemViewModel: element)
            }
            .disposed(by: dispose)
        
        output.selectedDone
            .drive()
            .disposed(by: dispose)
    }
    


}
