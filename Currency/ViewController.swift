//
//  ViewController.swift
//  Currency
//
//  Created by Alexandr on 7/12/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let date = "01.12.2014"
    let url = "https://api.privatbank.ua/p24api/exchange_rates?json&date="
    let api = WebAPI()
    var arrList = [CurrencyListResponse]()
    var arrCurrencyPB = [CurrencysAll]()
    var arrCurrencyNB = [CurrencysAll]()
    let  cellIdentifire = "Cell"
    
    var numberOfPB = 0
    var numberOfNB = 0
    
    @IBOutlet weak var dateB: UILabel!
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var table2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table1.delegate = self
        table2.delegate = self
        table1.dataSource = self
        table2.dataSource = self
        table1.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
        table2.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
        
        self.api.getAPI(url: url + date) { (Currency) in
            self.arrList = [Currency]
            self.arrCurrencyNB = Currency.exchangeRate
            self.arrCurrencyPB = Currency.exchangeRate.filter({ item -> Bool in
                item.saleRate != nil && item.purchaseRate != nil
            })
            self.dateB.text = self.arrList[0].date
            self.table1.reloadData()
            self.table2.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            numberOfPB = arrCurrencyNB.count
            return numberOfPB
        }
        else if tableView.tag == 2 {
            numberOfNB = arrCurrencyNB.count
            return numberOfNB
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! TableViewCell
        if tableView.tag == 1 {
            let arrPB = arrCurrencyPB[indexPath.row]
            let currency = arrPB.currency
            let buy = arrPB.purchaseRate
            let sale = arrPB.saleRate
            cell.currency.text = currency
            cell.buy.text = formatString(anotherType: buy!)
            cell.sale.text = formatString(anotherType: sale!)
        }
        else if (tableView.tag == 2) {
            let arrNB = arrCurrencyNB[indexPath.row]
            let currency = arrNB.currency
            let buy = arrNB.purchaseRateNB
            let sale = arrNB.saleRateNB
            cell.currency.text = currency
            cell.buy.text = formatString(anotherType: buy)
            cell.sale.text = formatString(anotherType: sale)
        }
        return cell
    }
    
    func formatString(anotherType: Double) -> String {
        let string = String(format: "%.2f", anotherType)
        return string
    }
    
    
}



