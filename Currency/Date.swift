//
//  Date.swift
//  Currency
//
//  Created by Alexandr on 7/14/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation

extension Date {
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: Date())
    }
}
