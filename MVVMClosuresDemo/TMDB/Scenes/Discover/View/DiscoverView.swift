//
//  DiscoverView.swift
//  MVVMClosuresDemo
//
//  Created by max on 2019/9/2.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import SnapKit

final class DiscoverView: UIView {
    
    private var dataSource: [CarouselViewModel]?
    private var storedOffsets = [Int: CGFloat]()
    private var tableView: UITableView {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
    private let selectedIndexSubject = PublishSubject<(Int, Int)>()
    var selectedIndex: Observable<(Int, Int)> {
        return selectedIndexSubject.asObserver()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func setup() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DiscoverView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = dataSource else {
            return UITableViewCell()
        }
    }
}


extension DiscoverView: UITableViewDelegate {
    
}
