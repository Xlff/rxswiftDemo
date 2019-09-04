//
//  MovieCell.swift
//  MVVMClosuresDemo
//
//  Created by max on 2019/9/4.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageV = UIImageView(image: UIImage.init(named: "sample"))
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        imageV.layer.cornerRadius = 16
        return imageV
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var  subtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(150)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    private struct Constants {
        static let maxHeight: CGFloat = 400
    }
    
    private static let sizingCell = MovieCell(frame: .zero)
    
    static func height(forWidth width: CGFloat) -> CGFloat {
        sizingCell.prepareForReuse()
        sizingCell.layoutIfNeeded()
        
        var fittingSize = UIView.layoutFittingCompressedSize
        fittingSize.width = width
        let size = sizingCell.contentView.systemLayoutSizeFitting(fittingSize,
                                                                  withHorizontalFittingPriority: .required,
                                                                  verticalFittingPriority: .defaultLow)
        return min(size.height, Constants.maxHeight)
    }
}
