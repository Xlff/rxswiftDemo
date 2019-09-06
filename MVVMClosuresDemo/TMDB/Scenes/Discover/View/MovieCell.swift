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
        label.font = UIFont.systemFont(ofSize: 15)
        label.contentMode = .center
        label.textColor = UIColor(r: 106, g: 106, b: 106)
        return label
    }()
    
    lazy var  subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.contentMode = .center
        label.textColor = UIColor(r: 106, g: 106, b: 106)
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        print(min(size.height, Constants.maxHeight))
        return min(size.height, Constants.maxHeight)
    }
}
