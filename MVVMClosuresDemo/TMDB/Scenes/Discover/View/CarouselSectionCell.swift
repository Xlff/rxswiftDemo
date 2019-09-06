//
//  CarouselSectionCell.swift
//  MVVMClosuresDemo
//
//  Created by max on 2019/9/4.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

final class CarouselSectionCell: UITableViewCell {
    var collectionViewHeightConstraint: NSLayoutConstraint {
        return NSLayoutConstraint()
    }
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 18, g: 18, b: 18)
        view.contentMode = .scaleToFill
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        titleLabel.snp.makeConstraints({ make in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        })
        
        subtitleLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(self.titleLabel)
        })
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(r: 108, g: 108, b: 108)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
        return collectionView
    }()
    
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: 140, height: 235)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(topView)
        contentView.addSubview(collectionView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(90.5)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(MovieCell.height(forWidth: 140))
            make.right.bottom.left.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselSectionCell {
    var collectionViewOffset: CGFloat {
        get { return collectionView.contentOffset.x }
        set { collectionView.contentOffset.x = newValue }
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
    
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate 
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
        collectionView.reloadData()
    }
}
