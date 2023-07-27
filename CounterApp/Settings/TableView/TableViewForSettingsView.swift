//
//  TableViewForSettingsView.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 18.07.2023.
//

import UIKit

class TableViewForSettingsView: UIView {
    
    let tasks = ["Vibration", "Sound", "NegativeNumbers"]
    
    var tableView = UITableView(frame: .zero, style: .insetGrouped)

    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

    override init(frame: CGRect){
        super.init(frame: frame)
        tableView.isScrollEnabled = false
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {

//        self.backgroundColor = UIColor.yellow

        // need to set color
        
        self.addSubview(tableView)
        
        tableView.frame = self.bounds
        tableView.rowHeight = 60

//        tableView.layer.backgroundColor = UIColor.systemGray5.cgColor
        
    }


}
extension TableViewForSettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell",
                                                 for: indexPath) as! SettingsTableViewCell
        
        
        cell.textLabel?.text = tasks[indexPath.row]
        cell.switchView.isOn = getArrayOfSettings()[indexPath.row] //переделать
        
        return cell
    }
    
}

extension TableViewForSettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
// Вызвать тут алерт на изменение счетчика
        
        
    }
    
    func getArrayOfSettings() -> [Bool] {
        let settings = StorageManager.shared.fetchSettings()
        let sound = settings.sound
        let vibration = settings.vibration
        let ottricatelnie = settings.ottricatelnie
        let settingsArray = [vibration, sound, ottricatelnie]
        return settingsArray
    }
}
