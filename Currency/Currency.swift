//
//  Currency.swift
//  Currency
//
//  Created by Alexandr on 7/12/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation



struct  CurrencyListResponse: Codable {
    
    let date: String
    let exchangeRate: [CurrencysAll]
    
    //    enum CodingKeys: String, CodingKey {
    //        case exchangeRate
    //    }
    
    
    
}


struct CurrencysAll: Codable, Equatable {
    var baseCurrency: String
    var currency: String
    var saleRateNB: Double
    var purchaseRateNB: Double
    var saleRate: Double?
    var purchaseRate: Double?
    
    
    
    enum CodingKeys: String, CodingKey {
        case baseCurrency
        case currency
        case saleRateNB
        case purchaseRateNB
        case saleRate
        case purchaseRate
    }
    
    
    //    init(from decoder: Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //
    //        self.baseCurrency = try container.decode(String.self, forKey: .baseCurrency)
    //        self.currency = try container.decode(String.self, forKey: .currency)
    //        self.saleRateNB = try container.decode(Double.self, forKey: .saleRateNB)
    //        self.purchaseRateNB = try container.decode(Double.self, forKey: .purchaseRateNB)
    ////        self.saleRate = try container.decode(Double.self, forKey: .saleRate)
    ////        self.purchaseRate = try container.decode(Double.self, forKey: .purchaseRate)
    //
    //    }
}
