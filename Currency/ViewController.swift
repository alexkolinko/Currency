//
//  ViewController.swift
//  Currency
//
//  Created by Alexandr on 7/12/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var arrList = [CurrencyListResponse]()
    var arrCurrencyPB = [CurrencysAll]()
    var arrCurrencyNB = [CurrencysAll]()
    var dateToday = String(Date.getCurrentDate())
    let api = WebAPI()
    let url = "https://api.privatbank.ua/p24api/exchange_rates?json&date="
    let cellIdentifire = "Cell"
    let formater = DateFormatter()
    let datePicker = UIDatePicker(frame: CGRect(x: 60, y: 50, width: 270, height: 100))
    let queueMain = DispatchQueue.main
    
    @IBOutlet weak var datePB: UILabel!
    @IBOutlet weak var dateNB: UILabel!
    @IBOutlet weak var tablePB: UITableView!
    @IBOutlet weak var tableNB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPPI()
        tablePB.delegate = self
        tableNB.delegate = self
        tablePB.dataSource = self
        tableNB.dataSource = self
        tablePB.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
        tableNB.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
    }
    
    @IBAction func dateButtonPB(_ sender: UIButton) {
        dateAlert()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return arrCurrencyPB.count
        }
        else if tableView.tag == 2 {
            return arrCurrencyNB.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! TableViewCell
        self.queueMain.async {
            if tableView.tag == 1 {
                let arrPB = self.arrCurrencyPB[indexPath.row]
                guard let currency = arrPB.currency, arrPB.currency != nil else {return}
                guard let buy = arrPB.purchaseRate, arrPB.purchaseRate != nil else {return}
                guard let sale = arrPB.saleRate, arrPB.saleRate != nil else {return}
                cell.currency.text = currency
                cell.buy.text = self.formatToString(anotherType: buy)
                cell.sale.text = self.formatToString(anotherType: sale)
            }
            else if tableView.tag == 2 {
                let arrNB = self.arrCurrencyNB[indexPath.row]
                guard let currency = arrNB.currency, arrNB.currency != nil else {return}
                guard let buy = arrNB.purchaseRateNB, arrNB.purchaseRateNB != nil else {return}
                guard let sale = arrNB.saleRateNB, arrNB.saleRateNB != nil else {return}
                cell.currency.text = currency
                cell.buy.text = self.formatToString(anotherType: buy)
                cell.sale.text = self.formatToString(anotherType: sale)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            let cellPB = tableView.cellForRow(at: indexPath) as! TableViewCell
            let currencyPB = cellPB.currency.text
            guard let index = arrCurrencyNB.firstIndex(where: {$0.currency == currencyPB!}) else {return}
            let indexPath = NSIndexPath(item: index, section: 0)
            tableNB.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
        } else if tableView.tag == 2 {
            let cellNB = tableView.cellForRow(at: indexPath) as! TableViewCell
            let currencyNB = cellNB.currency.text
            guard let index1 = arrCurrencyPB.firstIndex(where: {$0.currency == currencyNB!}) else {return}
            print(index1)
            let indexPath = NSIndexPath(item: index1, section: 0)
            tablePB.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
        }
    }
    
    func getAPPI() {
        self.api.getAPI(url: self.url + self.dateToday) { (Currency) in
            self.arrList = [Currency]
            self.arrCurrencyNB = Currency.exchangeRate.filter({ item -> Bool in
                item.baseCurrency != nil && item.currency != nil && item.saleRateNB != nil && item.purchaseRateNB != nil
            })
            self.arrCurrencyPB = Currency.exchangeRate.filter({ item -> Bool in
                item.baseCurrency != nil && item.currency != nil && item.saleRateNB != nil && item.purchaseRateNB != nil && item.saleRate != nil && item.purchaseRate != nil
            })
            self.queueMain.async {
                self.datePB.text = self.arrList[0].date
                self.dateNB.text = self.arrList[0].date
                self.tablePB.reloadData()
                self.tableNB.reloadData()
            }
        }
    }
    
    func dateAlert() {
        let alert = UIAlertController(title: "Выберите дату", message: "\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.isModalInPopover = true
        self.datePicker.datePickerMode = .date
        let localID = Locale.preferredLanguages.first
        self.datePicker.locale = Locale(identifier: localID!)
        alert.view.addSubview(self.datePicker)
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Подтвердить", style: .default, handler: { (UIAlertAction) in
            self.getDateFromDatePicker()
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    func getDateFromDatePicker() {
        self.formater.dateFormat = "dd.MM.yyyy"
        self.dateToday = formater.string(from: datePicker.date)
        getAPPI()
    }
    
    func formatToString<T>(anotherType: T) -> String {
        let s = String(format: "%.2f", anotherType as! CVarArg)
        return s
    }
    
}
