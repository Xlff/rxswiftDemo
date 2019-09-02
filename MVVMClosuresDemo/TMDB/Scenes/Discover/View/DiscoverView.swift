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


final class DiscoverView: UIView {
    
    private var dataSource: [CarouselViewModel]?
    private var storedOffsets = [Int: CGFloat]()
    private var tableView: UITableView {
        let tableView = UITableView()
        
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
    
    
    private func setup() {
        
    }
}
