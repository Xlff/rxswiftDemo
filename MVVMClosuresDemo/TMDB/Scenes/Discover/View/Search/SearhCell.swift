//
//  SearhCell.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/9/10.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

class SearhCell: UITableViewCell {
    
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .lightGray
        return label
    }()

    
    func setup() {
        contentView.addSubview(titleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        titleImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 74, height: 74))
            make.top.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleImageView).offset(-15)
            make.left.equalTo(titleImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleImageView).offset(10)
            make.left.right.equalTo(titleLabel)
        }
    }
    func configure(withImageUrl url: String?,
                   title: String,
                   subtitle: String) {
        if let url = url, let imageUrl = URL(string: url) {
            titleImageView.kf.setImage(with: imageUrl)
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

extension SearhCell {
    
    func configure(withSearchResultItemViewModel item: SearchResultItemViewModel) {
        configure(withImageUrl: item.imageUrl,
                  title: item.title,
                  subtitle: item.subtitle)
    }
}
