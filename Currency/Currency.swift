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
}

struct CurrencysAll: Codable {
    var baseCurrency: String?
    var currency: String?
    var saleRateNB: Double?
    var purchaseRateNB: Double?
    var saleRate: Double?
    var purchaseRate: Double?
}
