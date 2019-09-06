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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarouselSectionCell.self, forCellReuseIdentifier: String(describing: CarouselSectionCell.self))
        return tableView
    }()
    
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
    
    func setDataSource(_ dataSource: [CarouselViewModel]) {
        self.dataSource = dataSource
    }
    
    private func setup() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarouselSectionCell.self), for: indexPath) as! CarouselSectionCell
        let carous = data[indexPath.row]
        cell.titleLabel.text = carous.title
        cell.subtitleLabel.text = carous.subtitle
        return cell
    }
}

extension DiscoverView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CarouselSectionCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CarouselSectionCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension DiscoverView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexSubject.onNext((collectionView.tag, indexPath.item))
    }
}


extension DiscoverView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?[collectionView.tag].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = dataSource else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
        let item = data[collectionView.tag].items[indexPath.item]
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.subtitle
        if let url = item.imageUrl {
            cell.imageView.kf.setImage(with: URL(string: url))
        }
        return cell
    }
}

extension DiscoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4
        let width = collectionView.bounds.width / itemsPerRow
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
