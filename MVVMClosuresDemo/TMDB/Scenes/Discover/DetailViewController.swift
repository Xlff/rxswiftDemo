//
//  DetailViewController.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/29.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel!
    @IBOutlet weak var headerView: MovieDetailHeaderView!
    @IBOutlet weak var tipsView: MovieDetailTipsView!
    @IBOutlet weak var posterImageView: GradientImageView!
    @IBOutlet weak var backButton: UIButton!
    
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
    
    private func bindViewModel() {
        let input = DetailViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                          backTrigger: backButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.data
            .drive(onNext: { [weak self] data in
                guard let strongSelf = self, let data = data else { return }
                strongSelf.headerView.configure(with: data)
                strongSelf.tipsView.configure(with: data)
                if let urlString = data.posterUrl, let url = URL(string: urlString) {
                    self?.posterImageView.kf.setImage(with: url)
                }
                
            })
            .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
    }


}
