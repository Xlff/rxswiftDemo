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
        super.init(coder: aDecoder)
        setup()
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
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(40)
        }
        leftDotView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 3, height: 3))
            make.left.equalTo(genresLabel.snp.right).offset(12)
            make.centerY.equalTo(genresLabel)
        }
        runtimeLabel.snp.makeConstraints { make in
            make.left.equalTo(leftDotView.snp.right).offset(12)
            make.centerY.equalTo(genresLabel)
        }

        rightDotView.snp.makeConstraints { make in
            make.size.centerY.equalTo(leftDotView)
            make.left.equalTo(runtimeLabel.snp.right).offset(9.5)
        }
        starIconView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.centerY.equalTo(genresLabel)
            make.left.equalTo(rightDotView.snp.right).offset(12)
        }
        voteAverageLabel.snp.makeConstraints { make in
            make.left.equalTo(starIconView.snp.right).offset(12)
            make.centerY.equalTo(genresLabel)
        }

        overViewTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(genresLabel.snp.bottom).offset(40)
        }
        overViewContentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(overViewTitleLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(genresLabel)
        addSubview(overViewTitleLabel)
        addSubview(overViewContentLabel)
        addSubview(runtimeLabel)
        addSubview(voteAverageLabel)
        addSubview(leftDotView)
        addSubview(rightDotView)
        addSubview(starIconView)

    }
    
    func configure(withTitle title: String,
                   releaseDate: String,
                   genres: String,
                   runtime: String,
                   voteAverage: String,
                   overview: String) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        genresLabel.text = genres
        runtimeLabel.text = runtime
        voteAverageLabel.text = voteAverage
        overViewContentLabel.text = overview
    }
}

extension MovieDetailHeaderView {
    func configure(with data: MovieDetailData) {
        configure(withTitle: data.title,
                  releaseDate: data.releaseDate,
                  genres: data.genres,
                  runtime: data.runtime,
                  voteAverage: data.voteAverage,
                  overview: data.overview)
    }
}
