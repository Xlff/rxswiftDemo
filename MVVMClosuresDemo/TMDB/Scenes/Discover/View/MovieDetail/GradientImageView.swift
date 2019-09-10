//
//  GradientImageView.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/9/9.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup() {
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = 0.1
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor,
                           UIColor(r: 18, g: 18, b: 18).cgColor,
                           UIColor(r: 18, g: 18, b: 18).cgColor,
                           UIColor.clear.cgColor
        ]
        gradient.locations = [0, 0.1, 0.9, 1]
        layer.mask = gradient
    }

}
