//
//  MovieDetailHeaderView.swift
//  MVVMClosuresDemo
//
//  Created by max on 2019/9/7.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

final class MovieDetailHeaderView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 74, g: 74, b: 74)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var overViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "OverView"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var overViewContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(r: 74, g: 74, b: 74)
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    lazy var leftDotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = .white
        return dot
    }()
    lazy var rightDotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = .white
        return dot
    }()
    
    lazy var starIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star_icon"))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
        }
        genresLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(40)
            
        }
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(genresLabel)
        addSubview(overViewTitleLabel)
        addSubview(runtimeLabel)
        addSubview(voteAverageLabel)
        addSubview(overViewContentLabel)
        addSubview(leftDotView)
        addSubview(rightDotView)
        addSubview(starIconView)

    }
    
}
