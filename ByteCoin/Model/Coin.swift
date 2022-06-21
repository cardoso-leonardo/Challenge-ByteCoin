//
//  Coin.swift
//  ByteCoin
//
//  Created by Leonardo Cardoso on 20/06/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}



