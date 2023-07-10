//
//  SavedCountersViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 25.06.2023.
//

import UIKit

class SavedCountersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    let storageManager = StorageManager.shared
    
    var counters: [Counter] = []
    
    let tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        counters = storageManager.fetchAllCounters()
        setupNavigationBar()
        
        
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
// Вызвать тут алерт на изменение счетчика
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            counters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            storageManager.deleteCounter(at: indexPath.row)
        }
    }
    
    private func setupNavigationBar() {

        let deleteAllButton = UIBarButtonItem(title: "Delete all", style: .plain, target: self, action: #selector(deleteAllCounters))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))

        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = deleteAllButton
        
        
        deleteAllButton.tintColor = .systemRed

    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true)
    }
    
    
    @objc func deleteAllCounters() {
        showAlert()
        
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Are you sure, you want to delete all your counters?" ,
                                      preferredStyle: .alert)
        let gotItAction = UIAlertAction(title: "Yes",
                                        style: .default) {[self]_ in
            self.storageManager.deleteAllCounter()
            counters = storageManager.fetchAllCounters()
            self.tableView.reloadData()

        }
        
        let cancelAction = UIAlertAction(title: "No!", style: .destructive) {_ in
            self.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(gotItAction)
        
        present(alert, animated: true)
    }

}
