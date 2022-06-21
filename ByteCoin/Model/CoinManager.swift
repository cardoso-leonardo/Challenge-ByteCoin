//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

protocol CoinManagerDelegate {
    func didUpdateCurrency(coinLabel: String, price: String)
    func didFail(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "CA84899B-FF53-4E88-8515-842554C96055"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func fetchCurrencyData(for currentCurrency: String){
        let fullUrl = URL(string: "\(baseURL)/\(currentCurrency)?apikey=\(apiKey)")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: fullUrl!) { data, urlresponse, error in
            
            if let error = error {
                delegate?.didFail(error: error)
                return
            }
            if let data = jsonDecoder(data) {
                let price = String(format: "%.2f", data.rate)
                delegate?.didUpdateCurrency(coinLabel: data.asset_id_quote, price: price)
            }
        }
        task.resume()
    }
    
    func jsonDecoder(_ data: Data?) -> Coin? {
        if let data = data {
            do {
                let decodedData = try JSONDecoder().decode(Coin.self, from: data)
                return decodedData
            } catch {
                delegate?.didFail(error: error)
            }
        }
        return nil
    }
    
}
