//
//  MovieDetailTipsView.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/9/9.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

class MovieDetailTipsView: UIView {
    
    lazy var voteCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vote count"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 74, g: 74, b: 74)
        return line
    }()
    lazy var statusTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(voteCountTitleLabel)
        addSubview(voteCountLabel)
        addSubview(line)
        addSubview(statusTitleLabel)
        addSubview(statusLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        voteCountTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-10)
        }
        voteCountLabel.snp.makeConstraints { make in
            make.left.right.equalTo(voteCountTitleLabel)
            make.top.equalTo(voteCountTitleLabel.snp.bottom).offset(4)
        }
        
        line.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.left.equalTo(voteCountTitleLabel.snp.right).offset(20)
        }
        
        statusTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(line.snp.right).offset(20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
            make.centerY.equalTo(voteCountTitleLabel)
        }
        statusLabel.snp.makeConstraints { make in
            make.left.right.equalTo(statusTitleLabel)
            make.centerY.equalTo(voteCountLabel)
        }
    }
    
    
    func configure(withVoteCount voteCount: String,
                   status: String) {
        voteCountLabel.text = voteCount
        statusLabel.text = status
    }
}

extension MovieDetailTipsView {
    func configure(with data: MovieDetailData) {
        configure(withVoteCount: data.voteCount, status: data.status)
    }
}
