//
//  OutputHistoryViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 12/19/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class OutputHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HistoryProtocol {
    @IBOutlet weak var tableView: UITableView!
    var historyArray:[String] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableView", for: indexPath) as! OutputHistoryTableViewCell
        cell.label.text = historyArray.reversed()[indexPath.section]
        cell.contentView.transform = CGAffineTransform (scaleX: 1,y: -1)
        cell.accessoryView?.transform = CGAffineTransform (scaleX: 1,y: -1)
        return cell
    }
    
    func getHistoryArray(equation: String, result: String) {
        historyArray.append(equation +  "\n" + " = " + result)
    }
    func deleteAllHistory() {
        historyArray.removeAll()
        tableView.reloadData()
    }
    
    @objc func loadList(notification: NSNotification) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.transform = CGAffineTransform (scaleX: 1,y: -1)
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
}
