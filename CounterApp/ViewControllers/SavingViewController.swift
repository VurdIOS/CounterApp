//
//  SavingViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 25.06.2023.
//

import UIKit

class SavingViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    let storageManager = StorageManager.shared
    
    var counters: [Counter]!
    
    let tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        counters = storageManager.fetchAllCounters()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()

        content.text = counters[indexPath.row].name
        content.secondaryText = counters[indexPath.row].value.formatted()
       
        

        cell.contentConfiguration = content
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
