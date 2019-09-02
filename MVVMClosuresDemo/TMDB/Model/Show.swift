//
//  Show.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/9/2.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation

struct Show: Decodable {
    let id: Int
    let name: String
    let posterUrl: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, posterUrl = "poster_path", releaseDate = "first_air_date"
    }
}
