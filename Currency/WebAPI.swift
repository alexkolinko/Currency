//
//  WebAPI.swift
//  Currency
//
//  Created by Alexandr on 7/12/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import Foundation
import Alamofire


class WebAPI {
    
    let queue = DispatchQueue(label: "My queue", qos: .background, attributes: .concurrent)
    
    func getAPI(url: String, completed:@escaping (_ currencys: CurrencyListResponse)->Void){
        guard let testUrl = URL(string: url) else {return}
        AF.request(testUrl).validate().responseData(queue: self.queue) { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else {return}
                do{
                    let myResponse = try JSONDecoder().decode(CurrencyListResponse.self, from: data)
                    completed(myResponse)
                }
                catch{
                    print(error)
                }
            case .failure(_):
                print("Error")
            }
        }
    }
}
