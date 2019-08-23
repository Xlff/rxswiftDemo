//
//  FSOViewController.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/22.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FSOViewController: UIViewController {
    private let viewModel: FSOReposViewModel
    
    private let tableView = UITableView()
    let searchController = UISearchController.init(searchResultsController: nil)
    
    private let searchTextField = UITextField()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: FSOReposViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = nil
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        bindViewModel()
    }
    
    
    private func bindViewModel() {
        rx.viewWillAppear
            .asObservable()
            .subscribe(onNext: {
                [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.viewWillAppear()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {
                [weak self] indexPath in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.didSelect(index: indexPath)
            })
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .asObservable()
            .subscribe(onNext: {
                [weak self] query in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.didSearch(query: query)
            })
            .disposed(by: disposeBag)
        
        viewModel.repos
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                row, element, cell in
                cell.textLabel?.text = element.name
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedRepoId
            .drive(onNext: { [weak self] repoId in
                guard let strongSelf = self else { return }
                
                let alertController = UIAlertController(title: "\(repoId)", message: nil, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                strongSelf.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
    }
    
}
