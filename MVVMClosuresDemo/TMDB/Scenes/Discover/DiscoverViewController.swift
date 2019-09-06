//
//  DiscoverViewController.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/29.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverViewController: UIViewController {
    var viewModel: DiscoverViewModel!
    
    @IBOutlet weak var carouselsView: DiscoverView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func bindViewModel() {
        let input = DiscoverViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                            selected: carouselsView.selectedIndex
                                                .asDriver(onErrorJustReturn: (0, 0)))
        let output = viewModel.transform(input: input)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.results
            .drive(onNext: { [weak self] carouselViewModel in
                guard let strongSelf = self else { return }
                strongSelf.carouselsView.setDataSource(carouselViewModel)
                strongSelf.carouselsView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.selected
            .drive()
            .disposed(by: disposeBag)
    }

}
