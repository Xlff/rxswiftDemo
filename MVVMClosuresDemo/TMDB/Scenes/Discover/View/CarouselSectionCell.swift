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
    
    var titleLabel: UILabel {
        let label = UILabel()
        return label

    }
    
    var subtitleLabel: UILabel {
        let label = UILabel()
        return label
    }
    
    var collectionView: UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }
    
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: 140, height: 235)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
}
